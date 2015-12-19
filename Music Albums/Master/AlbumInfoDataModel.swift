//
//  AlbumDataModel.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

public struct AlbumInfoDataModel {
    var title: String
    var price: String
    var standardImageURL: String
    
    var artist = ""
    
    var description : String {
        var result = title
        if artist.characters.count > 1
        {
            result += " by " + artist
        }
        
        return result + " " + price }
    
    var shortTitle : String {
        
        if title.characters.count < 40
        {
            return title
        }
        
        let isSeparator : (Character)  -> Bool = { $0 == "/" || $0 == "-" || $0 == "("  }
        let fragmentsChar = title.characters.split( isSeparator: isSeparator)
        let fragments = fragmentsChar.map(String.init)
        
        
        return fragments.first ?? title
    }
}



    