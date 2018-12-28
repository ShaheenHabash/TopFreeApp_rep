//
//  vcWebView.swift
//  Top Free Apps
//
//  Created by Shaheen Al-Habash on 12/28/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import UIKit

class vcWebView: UIViewController {

    @IBOutlet weak var wvMain: UIWebView!
    
    var popOverVC:vcPopUp!
    var _vcNoInternet:vcNoInternet!
    
    var _UrlStr = ""
    var _BusyIndicaterCount = 0
    fileprivate var _IsShow = false
    //***********************************************************************************
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
        
        _BusyIndicaterCount += 1
        showPopUp(PopUpType.Indicator,vIndicatorString: "Loading")
        let xUrl = URL (string: _UrlStr)!
        let xRequestObj = URLRequest(url: xUrl);
        wvMain.loadRequest(xRequestObj);
        wvMain.delegate = self
    }
    //***********************************************************************************
    func showPopUp(_ vPopUpType : PopUpType ,vIndicatorString:String)
    {
        popOverVC = vcPopUp.instantiateFromStoryboard(vAppStoryboard: .Reference)
        popOverVC._PopUpType = vPopUpType
        popOverVC._IndicatorString = vIndicatorString
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.bounds
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    //***********************************************************************
    @IBAction func btnBack_Actions(_ sender: UIButton) {
        remove()
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
    //***********************************************************************************
}
//***********************************************************************************
//***********************************************************************************
extension vcWebView:UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        _BusyIndicaterCount -= 1
        if(_BusyIndicaterCount == 0)
        {
            popOverVC.removeAnimate()
        }
    }
}
//***********************************************************************************
//***********************************************************************************

