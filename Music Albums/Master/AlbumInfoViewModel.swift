//
//  AlbumViewModel.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

public struct AlbumViewModel {
    var title : String
    var detail : AlbumDetailedViewModel
    var image : UIImage { return detail.image }
}

