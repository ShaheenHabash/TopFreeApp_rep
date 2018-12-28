//
//  vcPopUp.swift
//  ASENEWS
//
//  Created by Shaheen Al-Habash on 5/17/17.
//  Copyright © 2017 ase. All rights reserved.
//

import UIKit

enum PopUpType : String {
    case Indicator
}

class vcPopUp: UIViewController {

    @IBOutlet weak var viewCenter: UIView!
    @IBOutlet weak var lblLoading: UILabel!
    @IBOutlet weak var aciActivityIndicator: UIActivityIndicatorView!
    
    public var _IndicatorString = "Downloading"
    public var _PopUpType = PopUpType.Indicator
    
    private var _IsShow = false
    //*********************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch _PopUpType {
        
        case PopUpType.Indicator:
            viewVisable(false)
            viewCenter.isHidden = false
            aciActivityIndicator.isHidden = false
            aciActivityIndicator.startAnimating()
            lblLoading.text = _IndicatorString
            if(LANGUAGE == "AR")
            {
                lblLoading.font = UIFont(name: "BahijJanna-Bold", size: lblLoading.font.pointSize)
            }
            //self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            lblLoading.font = lblLoading.font.withSize(29)
            
            viewCenter.layer.cornerRadius = 5;
            viewCenter.layer.masksToBounds = true;
            self.showAnimate()
        }
    }
    //*********************************************************************
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //***********************************************************************************
    func viewVisable(_ vIsVisable : Bool){
        aciActivityIndicator.isHidden = !vIsVisable
    }
    //***********************************************************************************
    func showAnimate()
    {
        _IsShow = true
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    //***********************************************************************************
    func removeAnimateAuto(){
        removeAnimate()
    }
    //***********************************************************************************
    func removeAnimate()
    {
        _IsShow = false
        UIView.animate(withDuration: 0.25, animations: {
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
//*********************************************************************
//*********************************************************************
