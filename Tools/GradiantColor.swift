//
//  GradiantColor.swift
//  aseLive
//
//  Created by anas liswe on 8/24/16.
//  Copyright © 2016 anas liswe. All rights reserved.
//

import Foundation
import UIKit

class GradiantColor {
    
    init(vStartColor:UIColor,vEndColor:UIColor){
    startColor=vStartColor
    endColor=vEndColor
       
        
        
            }
    
    
    var startColor = UIColor(red: 192.0/255.0, green: 38.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    var endColor = UIColor(red: 35.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1.0)
    var startPoint = CGPoint(x: 0,y: 0.5)
    var endPoint=CGPoint(x: 1,y: 0.5)
    
   /* let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ startColor.CGColor, endColor.CGColor]
        gl.startPoint = startPoint
        gl.endPoint = endPoint
    }*/
    
    func gradient(_ frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        //print(frame)
        if(LANGUAGE == "AR")
        {
            layer.startPoint = endPoint
            layer.endPoint = startPoint
        }
        else
        {
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
        layer.colors = [ startColor.cgColor,endColor.cgColor]
        return layer
    }
}
