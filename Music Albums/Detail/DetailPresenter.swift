//
//  DetailedPresenter.swift
//  Music Albums
//
//  Created by Geoff Burns on 19/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit


protocol DetailModuleInterface {

    func dismissDetails()

}

class DetailPresenter : DetailModuleInterface
{
    var wireframe : DetailWireframe?
    
    func dismissDetails()
    {
        wireframe?.dismissDetails()
    }
    
}


