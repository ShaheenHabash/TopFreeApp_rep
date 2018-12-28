//
//  tvcTopFreeCell.swift
//  Top Free Apps
//
//  Created by Shaheen Al-Habash on 12/27/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import UIKit
import SDWebImage

class tvcTopFreeCell: UITableViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var _Entity:TopFreeApp? {
        didSet {
            updatCell()
        }
    }
    //***********************************************************************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgImage.image = UIImage(named: "notavailable")
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
        self.contentView.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
        
        func styleImg(vUIImageView:UIImageView) {
            vUIImageView.layer.masksToBounds = true
            vUIImageView.layer.cornerRadius = 10
        }
        
        styleImg(vUIImageView:imgImage)
    }
    //***********************************************************************************
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //***********************************************************************
    override func prepareForReuse() {
        super.prepareForReuse()
        imgImage.image = UIImage(named: "notavailable")
        lblName.text = ""
    }
    //****************************************************************
    @IBAction func btnDetails_Action(_ sender: UIButton) {
        let xUserInfo = ["id" : _Entity!.Id]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tvcTopFreeCell_btnDetails_Action"), object: nil,userInfo:xUserInfo)
    }
    //****************************************************************
    func updatCell() {
        imgImage.image = UIImage(named: "notavailable")
        
        imgImage.sd_setShowActivityIndicatorView(true)
        imgImage.sd_setIndicatorStyle(.white)
        imgImage.sd_setImage(with: URL(string: _Entity!.Image53x), placeholderImage: UIImage(named: "notavailable"))
        
        lblName.text = _Entity!.Name
    }
    //***********************************************************************************
}
