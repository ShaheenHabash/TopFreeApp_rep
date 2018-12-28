//
//  AppStoryboard.swift
//  Sports Hub
//
//  Created by Shaheen Al-Habash on 4/15/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main,Reference
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(vViewControllerClass : T.Type) -> T {
        let storybordID = (vViewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storybordID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
extension UIViewController {
    class var storyboardID : String {
        return "\(self)Id"
    }
    
    static func instantiateFromStoryboard(vAppStoryboard : AppStoryboard) -> Self{
        return vAppStoryboard.viewController(vViewControllerClass: self)
    }
}
