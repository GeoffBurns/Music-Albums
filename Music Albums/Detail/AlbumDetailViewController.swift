//
//  AlbumDetailViewController.swift
//  Music Albums
//
//  Created by Geoff Burns on 18/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.


import UIKit

protocol DetailViewInterface
{
    var albumDetail : AlbumDetailedViewModel? { get set }
}

class AlbumDetailViewController: UIViewController, DetailViewInterface {

    @IBOutlet var discriptionLabel: UILabel!
    @IBOutlet var albumCover: UIImageView!
    @IBOutlet var backButton: UIButton!
    var albumDetail : AlbumDetailedViewModel?
    
    var eventHandler : DetailModuleInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let details = albumDetail
        {
            albumCover.contentMode = .ScaleAspectFit
            albumCover.image = details.image
            discriptionLabel.text = details.description
        }
    }

    
    @IBAction func backButtonPushed(sender: AnyObject) {

        eventHandler?.dismissDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
