//
//  vcHome.swift
//  Top Free Apps
//
//  Created by Shaheen Al-Habash on 12/27/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import UIKit

class vcHome: UIViewController {
    
    @IBOutlet weak var tvMain: UITableView!{
        didSet {
            tvMain.rowHeight = UITableView.automaticDimension
            tvMain.estimatedRowHeight = 290
        }
    }
    var refreshControl: UIRefreshControl!
    var _IsRefresh = false
    
    var _ListTopFreeApp = [TopFreeApp]()
    
    var popOverVC:vcPopUp!
    var _vcNoInternet:vcNoInternet!
    var _VcDetails:vcDetails!
    
    var _BusyIndicaterCount = 0
    //***********************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ** Add Listener to seanse NETWORK statuse
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        // ## Add Listener to seanse NETWORK statuse
        
        //**Setting TableView
        refreshControl = UIRefreshControl()
        
        let xAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 13.0)!,NSAttributedString.Key.foregroundColor : UIColor.gray]
        let xAttributedTitle = NSAttributedString(string: "Pull to refresh", attributes: xAttributes)
        refreshControl.attributedTitle = xAttributedTitle
        refreshControl.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        tvMain.addSubview(refreshControl)
        tvMain.dataSource = self
        tvMain.delegate = self
        tvMain.register(UINib(nibName: "xibTopFreeCell", bundle: nil), forCellReuseIdentifier: "tvcTopFreeCellId")
        tvMain.tableFooterView = UIView(frame:CGRect.zero)
        //##Setting TableView
        
        //**Notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.tvcTopFreeCell_btnDetails_Action), name: NSNotification.Name(rawValue: "tvcTopFreeCell_btnDetails_Action"), object: nil)
        //##Notification
        
        reloadPage(vAddIndicator:true,vPageNo:1)
    }
    //***********************************************************************
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //*****************************************************************
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (reachabilityStatus != NOACCESS && _vcNoInternet != nil) {
            _vcNoInternet.remove()
        }
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //***********************************************************************************
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -60 && !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
            //your code for refresh
            
            let xAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 13.0)!,NSAttributedString.Key.foregroundColor : UIColor.gray]
            let xAttributedTitle = NSAttributedString(string: "Refreshing", attributes: xAttributes)
            refreshControl.attributedTitle = xAttributedTitle
            
            _IsRefresh = true
            reloadPage(vAddIndicator:false,vPageNo: 1)
        }
    }
    //***********************************************************************************
    @objc func tvcTopFreeCell_btnDetails_Action(_ notification: Notification) {
        guard let xId = notification.userInfo?["id"] as? String else { return }
        var xTopFreeApp = TopFreeApp()
        for(_,iEntity)in _ListTopFreeApp.enumerated()
        {
            if(xId == iEntity.Id)
            {
                xTopFreeApp = iEntity
                break
            }
        }
        
        if(_VcDetails != nil)
        {
            _VcDetails.remove()
        }
        _VcDetails =  vcDetails.instantiateFromStoryboard(vAppStoryboard: .Main)
        _VcDetails._TopFreeApp = xTopFreeApp
        self.addChild(_VcDetails)
        _VcDetails.view.frame = self.view.bounds
        self.view.addSubview(_VcDetails.view)
        _VcDetails.didMove(toParent: self)
    }
    //***********************************************************************************
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tvcTopFreeCell_btnDetails_Action"), object: nil)
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
    func reloadPage(vAddIndicator:Bool,vPageNo:Int)
    {
        if(vAddIndicator)
        {
            _BusyIndicaterCount += 1
            showPopUp(PopUpType.Indicator,vIndicatorString: "Loading")
        }
        API.getTopFreeApp("\(SERVER_IP)/topfreeapplications/limit=50/json",completion: didGetTopFreeApp)
    }
    //***********************************************************************************
    func didGetTopFreeApp(_ vErrorCode: Int,vErrorDiscription:String,vListTopFreeApp:[TopFreeApp]) {
        if(vErrorCode == 0)
        {
            _ListTopFreeApp = vListTopFreeApp
            if(_IsRefresh)
            {
                _IsRefresh = false
                refreshControl.endRefreshing()
            }
            else
            {
                _BusyIndicaterCount -= 1
                if(_BusyIndicaterCount == 0)
                {
                    popOverVC.removeAnimate()
                }
            }
            
            if(_ListTopFreeApp.count > 0)
            {
                tvMain.reloadData()
            }
        }
        else
        {
            _BusyIndicaterCount = 0
            popOverVC.removeAnimate()
            
            let alert = UIAlertController(title: "SORRY", message: vErrorDiscription, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            {
                action -> Void in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        let xAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 13.0)!,NSAttributedString.Key.foregroundColor : UIColor.gray]
        let xAttributedTitle = NSAttributedString(string: "Pull to refresh", attributes: xAttributes)
        refreshControl.attributedTitle = xAttributedTitle
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
    //***********************************************************************
}
//***********************************************************************************
//***********************************************************************************
extension vcHome:UITableViewDataSource {
    //***********************************************************************************
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //***********************************************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _ListTopFreeApp.count
    }
    //***********************************************************************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvcTopFreeCellId", for: indexPath) as! tvcTopFreeCell
        cell._Entity = _ListTopFreeApp[indexPath.row]
        
        return cell
    }
}
//***********************************************************************************
//***********************************************************************************
extension vcHome:UITableViewDelegate {
    
}
//***********************************************************************************
//***********************************************************************************
