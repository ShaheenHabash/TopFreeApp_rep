//
//  vcDetails.swift
//  Top Free Apps
//
//  Created by Shaheen Al-Habash on 12/27/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import UIKit
import ImageSlideshow
import SafariServices

class vcDetails: UIViewController {

    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    
    var _vcNoInternet:vcNoInternet!
    var _VcWebView:vcWebView!
    
    var _TopFreeApp = TopFreeApp()
    
    fileprivate var _IsShow = false
    //****************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // ** Add Listener to seanse NETWORK statuse
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        // ## Add Listener to seanse NETWORK statuse
    }
    
    //***********************************************************************************
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadPage()
    }
    //***********************************************************************
    @IBAction func btnBack_Actions(_ sender: UIButton) {
        remove()
    }
    //***********************************************************************
    @IBAction func btnGet_Action(_ sender: UIButton) {
//        UIApplication.shared.openURL(NSURL(string: _TopFreeApp.Link)! as URL)
        
//        let xSvc = SFSafariViewController(url: URL(string:_TopFreeApp.Link)!)
//        self.present(xSvc, animated: true, completion: nil)
        
        if(_VcWebView != nil)
        {
            _VcWebView.remove()
        }
        _VcWebView =  vcWebView.instantiateFromStoryboard(vAppStoryboard: .Reference)
        _VcWebView._UrlStr = _TopFreeApp.Link
        self.addChild(_VcWebView)
        _VcWebView.view.frame = self.view.bounds
        self.view.addSubview(_VcWebView.view)
        _VcWebView.didMove(toParent: self)
    }
    //***********************************************************************
    func reloadPage()
    {
        slideshow.backgroundColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 0)
        //            slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.insideScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor(red: 93.0/255.0, green: 227.0/255.0, blue: 197.0/255.0, alpha: 1)
        slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.circular = false
        slideshow.contentScaleMode = UIView.ContentMode.scaleAspectFit
        //            slideshow.contentScaleMode = UIViewContentMode.scaleToFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs([KingfisherSource(urlString: _TopFreeApp.Image100x)!])
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(vcDetails.didTap))
        slideshow.addGestureRecognizer(recognizer)
        
        lblName.text = _TopFreeApp.Name
        lblPrice.text = "\(_TopFreeApp.Price) \(_TopFreeApp.Currency)"
        lblCategory.text = _TopFreeApp.Category
        lblDate.text = _TopFreeApp.ReleaseDate
        lblSummary.text = _TopFreeApp.Summary
    }
    //********************************************************************
    @objc func didTap() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    //***********************************************************************************
    func show()
    {
        _IsShow = true
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    //***********************************************************************************
    public func remove()
    {
        _IsShow = false
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        });
    }
    //***********************************************************************************
    @objc func reachabilityStatusChanged()
    {
        if reachabilityStatus == NOACCESS {
            if(_vcNoInternet != nil)
            {
                _vcNoInternet.remove()
            }
            _vcNoInternet = vcNoInternet.instantiateFromStoryboard(vAppStoryboard: .Reference)
            self.addChild(_vcNoInternet)
            _vcNoInternet.view.frame = self.view.bounds
            self.view.addSubview(_vcNoInternet.view)
            _vcNoInternet.didMove(toParent: self)
        }
    }
    //****************************************************************
}
