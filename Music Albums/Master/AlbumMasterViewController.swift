//
//  ViewController.swift
//  Music Albums
//
//  Created by Geoff Burns on 17/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

protocol MasterViewInterface
{
    var currentPage : Int { get set }
    func addAlbum(i: Int, album: AlbumViewModel)
    var albumTitle : String { get set }
}

class AlbumMasterViewController: UIViewController, UIScrollViewDelegate, MasterViewInterface  {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nextButton: UIButton!

    var currentPage = 0 { didSet { pageControl.currentPage = currentPage }}
 
    
    var albumTitle : String {
        get { return self.titleLabel.text! }
        set(newValue) { self.titleLabel.text = newValue }
    }

    var eventHandler : MasterModuleInterface?
    let screenSize = UIScreen.mainScreen().bounds.size


    var albums = [AlbumViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configurePageControl()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        
        eventHandler?.loadView(screenSize)
        
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.scrollView.pagingEnabled = true

        pageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func addAlbum(i: Int, album albumViewModel: AlbumViewModel)
    {
        var frame = self.scrollView.bounds
        frame.origin.x = frame.size.width * CGFloat(i)
        frame.origin.y = 0.0
        frame = CGRectInset(frame, 10.0, 0.0)
        
        let subView = UIImageView(image: albumViewModel.image)
        subView.frame.origin.x = albumViewModel.image.size.width*CGFloat(i)
        subView.contentMode = .ScaleAspectFit
        subView.frame = frame
        
        self.scrollView .addSubview(subView)
        
        self.albums.append(albumViewModel)
        self.pageControl.numberOfPages = i
        if i == 0
        {
            self.titleLabel.text = albumViewModel.title
        }
        self.scrollView.contentSize = CGSizeMake(self.screenSize.width*CGFloat(i+1), self.scrollView.frame.size.height)
    }

    @IBAction func nextButtonPressed(sender: AnyObject) {
        
      eventHandler?.showDetails()
    }
   
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        
        self.pageControl.numberOfPages = 1
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        self.view.addSubview(pageControl)
    }

    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPointMake(x, 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
       let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        
       eventHandler?.changePageTo(pageNumber)
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
     
    }
    
    
   

}

