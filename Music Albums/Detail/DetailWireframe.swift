//
//  DetailsWireframe.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

let AlbumDetailViewControllerIdentifier = "AlbumDetailViewController"

class DetailWireframe
{
    var presentedViewController : UIViewController?
    var presenter :  DetailPresenter
    
    init(presenter :  DetailPresenter)
    {
     self.presenter = presenter
     presenter.wireframe = self
    }
    
    func presentAlbumDetailsFrom(viewController: UIViewController, album:AlbumDetailedViewModel) {
        let newViewController = albumDetailViewController()

        newViewController.albumDetail = album
        newViewController.eventHandler = presenter
        viewController.presentViewController(newViewController, animated: true, completion: nil)
        
        presentedViewController = newViewController
    }
    
    func dismissDetails() {
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func albumDetailViewController() -> AlbumDetailViewController {
        let storyboard = mainStoryboard()
        let detailViewController: AlbumDetailViewController =
                    storyboard
                        .instantiateViewControllerWithIdentifier(
                            AlbumDetailViewControllerIdentifier)
                                as! AlbumDetailViewController
        
        return detailViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
    

}