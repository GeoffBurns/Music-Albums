//
//  AppDependancies.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

class AppDependencies {
    var masterWireframe = MasterWireframe()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        masterWireframe.presentMasterViewFromWindow(window)
    }
    
    func configureDependencies() {

        let webServices = WebServices()
        
        let albumInfoDataManager = AlbumInfoDataManager(webServices: webServices)
        let albumImageDataManager = AlbumImageDataManager(webServices: webServices)
        let albumInteractor = AlbumInteractor(
               albumInfoDataManager: albumInfoDataManager,
               albumImageDataManager: albumImageDataManager)
        
          let masterPresenter = MasterPresenter(albumInteractor:albumInteractor)
        let detailPresenter = DetailPresenter()
        let detailWireframe = DetailWireframe(presenter: detailPresenter)
        
        masterWireframe.detailsWireframe = detailWireframe
        masterWireframe.presenter = masterPresenter
        
    
    }
}