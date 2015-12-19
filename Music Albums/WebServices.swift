//
//  WebServices.swift
//  Music Albums
//
//  Created by Geoff Burns on 19/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import Foundation

struct WebServices
{
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        if(error != nil) {
            // If there is an error in the web request, print it to the console
            print(error!.localizedDescription)
        }
        completion(data: data, response: response, error: error)
        }.resume()
    }
    
    func ituneSearchUrl(searchTerm:String) -> String?
        
    {
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            return "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music&entity=album"
        }
        return nil
    }
    
    func convertDataToDictionary(data:NSData) -> NSDictionary
    {
        var jsonResult : NSDictionary = NSDictionary()
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
        } catch let error as NSError {
            print("JSON Error: \(error.localizedDescription)")
        }
        return jsonResult
    }
    
}