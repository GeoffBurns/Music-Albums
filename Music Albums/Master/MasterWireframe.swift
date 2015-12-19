//
//  MasterWireframe.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

let AlbumMasterViewControllerIdentifier = "AlbumMasterViewController"

class MasterWireframe  {
    var detailsWireframe : DetailWireframe?
    var albumMasterViewController : AlbumMasterViewController?
    var presenter :  MasterPresenter?
    
    func presentMasterViewFromWindow(window: UIWindow) {
        let viewController = masterViewController()

        albumMasterViewController = viewController
        window.rootViewController = viewController
    }
 
    
    func presentDetails(album: AlbumDetailedViewModel) {
        detailsWireframe?.presentAlbumDetailsFrom(albumMasterViewController!, album: album)
    }
    
    func masterViewController() -> AlbumMasterViewController {
        
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(AlbumMasterViewControllerIdentifier) as! AlbumMasterViewController
        

        viewController.eventHandler = presenter
        presenter!.view = viewController
        presenter!.wireframe = self
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    
}
