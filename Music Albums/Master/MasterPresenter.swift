//
//  MasterPresenter.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit


protocol MasterModuleInterface {
    func changePageTo(pageNumber:Int)
    func showDetails()
    mutating func loadView(screenSize: CGSize)
}

class MasterPresenter : MasterModuleInterface
{
    
    var albumInteractor:  AlbumInteractor
    var wireframe : MasterWireframe?
    var view : MasterViewInterface?
    
    var albums = [AlbumViewModel]()
    
    init(albumInteractor:AlbumInteractor)
    {
        self.albumInteractor = albumInteractor
    }
    func changePageTo(pageNumber:Int)
    {
        if self.albums.count > pageNumber
        {
            view?.currentPage = pageNumber
            view?.albumTitle = self.albums[pageNumber].title
        }
        else
        {
            view?.albumTitle = "End of List"
        }
    }
    func showDetails()
    {
        wireframe?.presentDetails(self.albums[view!.currentPage].detail)
    }
    func loadView(screenSize: CGSize)
       {
        albumInteractor.requestAlbumsFor("Eva Cassidy", imageSize: CGSize(width: screenSize.width, height: screenSize.height * 0.6)) {
            albumViewModel in
                  let i = self.albums.count
                  self.albums.append(albumViewModel)
                  self.view?.addAlbum(i, album: albumViewModel  )
        }
    }
}