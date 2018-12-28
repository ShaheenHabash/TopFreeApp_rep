//
//  MyError.swift
//  FitCoin
//
//  Created by Shaheen Al-Habash on 8/26/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import Foundation

enum MyError : Error {
    case noError
    ,apiError
    ,myError(vError_code: Int,vError_message:String)
}
