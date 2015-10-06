//
//  Foursquare.swift
//  Venues
//
//  Created by Paul Vagner on 10/6/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit

typealias Dictionary = [String:AnyObject]

import CoreLocation

private let API_URL = "https://api.foursquare.com/v2/"




//private - keeps the _singleton only accessable within the current scope. (this file only). "_" makes it a hidden variable
private let _singleton = Foursquare()


class Foursquare: NSObject {
    //func can only be ran on the class and not an instance of the class
    class func session () -> Foursquare {
        
        return _singleton
        
    }
    //venues - will be an array
    var venues: [Dictionary] = []
    
    func getVenuesWithLocation(location: CLLocation,completion: () -> ()) {
        
        
        let urlString = API_URL + "venues/search?v=20130815&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        if let url = NSURL(string: urlString) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = "GET"
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                
                if let d = data {
                    
                    if let resultInfo = try? NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? Dictionary {
                        
                        if let responseInfo = resultInfo?["response"] as? Dictionary {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                            self.venues = responseInfo["venues"] as? [Dictionary] ?? []
                            
                            completion()
                            
                            })
                            
//                            print (self.venues)
                            
                            
                        }
                        
                        
                        
                    }
                    
                }
                
            })
           
            task.resume()
            
            
        }
        
    }
    
}


//classname.classmethod

