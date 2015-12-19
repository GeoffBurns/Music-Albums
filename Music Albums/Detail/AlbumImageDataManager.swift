//
//  AlbumImageDataManager.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//


import UIKit


extension AlbumInfoDataModel
{
    static let sizeOptions = [250,340,400,450,460,600,1200]
    
    static func sizeOption(imageSize: CGSize) -> Int {
        let constrait = min(imageSize.width,imageSize.height)
        let sizes = sizeOptions.filter { CGFloat($0) < constrait}
        return sizes.last ?? 225
    }
    
    
    func imageUrlFor(sizeOption:Int) -> String
    {
        let sizeString = String(format: "%dx%d",  sizeOption , sizeOption)
        return  self.standardImageURL.stringByReplacingOccurrencesOfString("100x100", withString: sizeString)
    }
    
}
extension AlbumDataModel
{
    var description : String {
        var result = info.title
        if info.artist.characters.count > 1
        {
            result += " by " + info.artist
        }
        
        return result + " " + info.price }
    
    var shortTitle : String {
        
        if info.title.characters.count < 40
        {
            return info.title
        }
        
        let isSeparator : (Character)  -> Bool = { $0 == "/" || $0 == "-" || $0 == "("  }
        let fragmentsChar = info.title.characters.split( isSeparator: isSeparator)
        let fragments = fragmentsChar.map(String.init)
        
        
        return fragments.first ?? info.title
    }
}

struct AlbumImageDataManager
{
    static let maxImages = 20
    
    var webServices : WebServices
    
    func onRecievedAlbumInfo(albums: [AlbumInfoDataModel], imageSize: CGSize, onRecieveEachAlbumCover: (AlbumDataModel)->()) {
        
        let sizeOption = AlbumInfoDataModel.sizeOption(imageSize)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        for (i, album) in albums.enumerate()
        {
            self.addImageFor(i, album: album, sizeOption: sizeOption, onRecieveAlbumCover: onRecieveEachAlbumCover)
            if i >= AlbumImageDataManager.maxImages { break }
        }
    }
    

    func addImageFor(i: Int, album: AlbumInfoDataModel, sizeOption:Int, onRecieveAlbumCover: (AlbumDataModel)->())
    {
        let largeImageUrl = album.imageUrlFor(sizeOption)
        
        if  let url = NSURL(string: largeImageUrl)
        {
            webServices.getDataFromUrl(url) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    
                    if let image = UIImage(data: data)
                    {
                        onRecieveAlbumCover(AlbumDataModel(info:album,image: image))
                    }
                }
            }
        }
        
    }
    
    
}