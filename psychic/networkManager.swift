//
//  networkManager.swift
//  psychic
//
//  Created by Chris Goodwin on 2/8/15.
//  Copyright (c) 2015 Sleepy Mongoose. All rights reserved.
//

import Foundation



class networkManager {
    
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"com.sleepymongoose", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }

    class func getWithSuccess(appurl:String, success: ((appData: NSData!) -> Void)) {
        
        self.loadDataFromURL(NSURL(string: appurl)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                
                success(appData: urlData)
            }
        })
    }
}