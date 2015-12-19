//
//  AlbumInteractor.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit


struct AlbumInteractor
{
    let albumInfoDataManager : AlbumInfoDataManager
    let albumImageDataManager : AlbumImageDataManager
    
    func requestAlbumsFor(Search:String, imageSize: CGSize, addAlbum: (AlbumViewModel)->())
    {
        albumInfoDataManager.searchItunesFor(Search)
            { albums in
      
                self.albumImageDataManager.onRecievedAlbumInfo(albums, imageSize: imageSize) {
                    album in
                    let albumViewModel = AlbumViewModel(
                        title: album.shortTitle,
                        detail: AlbumDetailedViewModel(
                            description:album.description,
                            image:album.image))
                    addAlbum(albumViewModel)
                }}
    }
}