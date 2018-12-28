//
//  vcNoInternet.swift
//  Sports Hub
//
//  Created by Shaheen Al-Habash on 4/16/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import UIKit

class vcNoInternet: UIViewController {

    @IBOutlet weak var btnRetry: UIButton!
    fileprivate var _IsShow = false
    //*********************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //**btnRetry
        btnRetry.clipsToBounds = true
        btnRetry.layer.cornerRadius = 5
        btnRetry.layer.borderColor = UIColor.darkGray.cgColor
        btnRetry.layer.borderWidth = 2.0
        //##btnRetry
    }
    //*********************************************************************
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //***********************************************************************
    @IBAction func btnRetry_Action(_ sender: UIButton) {
        //**Check internet connection
        reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
        statusChangedWithReachability(reachability!)
        //##Check internet connection
        
        if reachabilityStatus != NOACCESS {
            remove()
        }
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
            }
        });
    }
    //*********************************************************************
}
