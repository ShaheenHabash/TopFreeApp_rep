//
//  myExtensions.swift
//  Sports Hub
//
//  Created by Shaheen Al-Habash on 4/17/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import Foundation
import UIKit

//*****************************************************************
public func isTextFieldEmpty (_ vUITextField:UITextField) -> Bool{
    return vUITextField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""
}
//*****************************************************************
public func isTextViewEmpty (_ vUITextView:UITextView) -> Bool{
    return vUITextView.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""
}
//*****************************************************************
public func isLableEmpty (_ vUILabel:UILabel) -> Bool{
    return vUILabel.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""
}
//*****************************************************************
public func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
//*****************************************************************
public func UTC_TO_CITY(vDateString:String,vFromDateFormat:String,vToDateFormat:String) -> String {
    let xFormatter = DateFormatter()
    xFormatter.dateFormat = vFromDateFormat
    xFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    let xDate = xFormatter.date(from: vDateString)
    xFormatter.timeZone = TimeZone.current
    xFormatter.dateFormat = vToDateFormat
    
    return xFormatter.string(from: xDate!)
}
//*****************************************************************
public func DateToChar(vDate:Date,vDateFormat:String) -> String {
    let xFormatter = DateFormatter()
    xFormatter.dateFormat = vDateFormat
    xFormatter.timeZone = TimeZone.current
    
    return xFormatter.string(from: vDate)
}
//*****************************************************************
public func CharToDate(vDateString:String,vFromDateFormat:String) -> Date {
    let xFormatter = DateFormatter()
    xFormatter.dateFormat = vFromDateFormat
    xFormatter.timeZone = TimeZone.current
    
    return xFormatter.date(from: vDateString)!
}
//*****************************************************************
public func statusChangedWithReachability(_ currentReachabilityStatus: Reachability) {
    let networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
    switch networkStatus.rawValue {
    case NotReachable.rawValue :
        reachabilityStatus = NOACCESS
    case ReachableViaWiFi.rawValue :
        reachabilityStatus = WIFI
    case ReachableViaWWAN.rawValue :
        reachabilityStatus = WWAN
    default:return
    }
    NotificationCenter.default.post(name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
}
//***********************************************************************************
public func verifyUrl (urlString: String?) -> Bool {
    //Check for nil
    if let urlString = urlString {
        // create NSURL instance
        let urlwithPercentEscapes = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: urlwithPercentEscapes!) {
            // check if your application can open the NSURL instance
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}
//*****************************************************************
public func Toast(vView:UIView,vMessage:String)
{
    let toastLabel = UILabel(frame: CGRect(x: vView.frame.size.width/2 - 125, y: vView.frame.size.height-100, width: 250, height: 70))
    toastLabel.numberOfLines = 5
    toastLabel.backgroundColor = UIColor(red: 222.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 0.4)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = NSTextAlignment.center;
    //    toastLabel.font = UIFont(name: "BahijJanna", size: 14.0)
    vView.addSubview(toastLabel)
    toastLabel.text = vMessage
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
        
        toastLabel.alpha = 0.0
        
    }, completion: {finished in
    })
}
//*****************************************************************
