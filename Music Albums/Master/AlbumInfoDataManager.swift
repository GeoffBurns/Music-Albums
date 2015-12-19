//
//  AlbumInfoDataManager.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

public extension SequenceType where Generator.Element == AlbumInfoDataModel
{
    @warn_unused_result
    public func uniques() -> [AlbumInfoDataModel] {
        var prevs: Set<String> = []
        var uniqs: [AlbumInfoDataModel] = []
        for el in self where !prevs.contains(el.title.lowercaseString) {
            prevs.insert(el.title.lowercaseString)
            uniqs.append(el)
        }
        return uniqs
    }
}

struct AlbumInfoDataManager
{
    static let maxImages = 20
    
    var webServices : WebServices
    
    func onRecievedAlbumInfo(jsonResultsContainingAlbumList: NSDictionary, processAlbumList: [AlbumInfoDataModel]->()) {
        let albumListRawData =
                    jsonResultsContainingAlbumList["results"] as! NSArray
        dispatch_async(dispatch_get_main_queue(), {   
            processAlbumList(self.albumInfoDataModelsFor(albumListRawData))
        })
    }
    
    func get(path: String, processAlbumList: [AlbumInfoDataModel]->())
    {
    get(path) { jsonResults in self.onRecievedAlbumInfo(jsonResults, processAlbumList: processAlbumList) }
    }
    
    func get(path: String, processData :  (NSDictionary)->()) {
        
        
        if  let url = NSURL(string: path)
        {
            self.webServices.getDataFromUrl(url) { (data, response, error)  in

             if let albumData = data
                {
                let  jsonResult =  self.webServices.convertDataToDictionary(albumData)
        
                processData(jsonResult)
                }
            }
        }
    }
    
    func searchItunesFor(searchTerm: String, processAlbumList: [AlbumInfoDataModel]->()) {
        
        if let urlPath = webServices.ituneSearchUrl(searchTerm)  {

            get(urlPath, processAlbumList: processAlbumList)
        }
    }
    
    
    func albumInfoDataModelsFor(allResults: NSArray) -> [AlbumInfoDataModel] {
        
        // Create an empty array of Albums to append to from this list
        var albums = [AlbumInfoDataModel]()
        
        // Store the results in our table data array
        if allResults.count>0 {
            
            // Sometimes iTunes returns a collection, not a track, so we check both for the 'name'
            for result in allResults {
                
                if let albumInfo = result as? NSDictionary
                {
                    let newAlbum = albumInfoDataModelFor(albumInfo)
                    
                    albums.append(newAlbum)
                }
            }
        }
        return albums.uniques().sort { $0.title < $1.title }
    }
    
    
    func albumInfoDataModelFor(albumInfo: NSDictionary) -> AlbumInfoDataModel {
        
        var name = albumInfo["trackName"] as? String
        if name == nil {
                            name = albumInfo["collectionName"] as? String
                        }
          /// helps remove duplicates
        name = name?.stringByReplacingOccurrencesOfString(" (International Version)", withString: "")
                        
          // Sometimes price comes in as formattedPrice, sometimes as collectionPrice.. and sometimes it's a float instead of a string. Hooray!
        var price = albumInfo["formattedPrice"] as? String
        if price == nil {
                            price = albumInfo["collectionPrice"] as? String
                            if price == nil {
                                let priceFloat: Float? = albumInfo["collectionPrice"] as? Float
                                let nf: NSNumberFormatter = NSNumberFormatter()
                                nf.maximumFractionDigits = 2
                                if priceFloat != nil {
                                    price = "$"+nf.stringFromNumber(priceFloat!)!
                                }
                            }
                        }
                        
        let imageURL = albumInfo["artworkUrl100"] as? String ?? ""
                        let singer = albumInfo["artistName"] as? String ?? ""
                        
        return AlbumInfoDataModel(title: name! , price: price ?? "",standardImageURL: imageURL, artist: singer)

        }
   
}
    