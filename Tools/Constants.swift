//
//  Constants.swift
//  aseLive
//
//  Created by anas liswe on 8/18/16.
//  Copyright © 2016 anas liswe. All rights reserved.
//

import Foundation
import UIKit

typealias JSONDictionary = [String: AnyObject]
typealias JSONArray = Array<AnyObject>

let WIFI = "WIFI Available"
let NOACCESS = "No Internet Access"
let WWAN = "Cellular Access Available"
var reachability : Reachability?
var reachabilityStatus = ""

var landscape = "Oriantation landscape"
var portrait = "Oriantation portrait"

let SERVER_DOMAIN = "itunes.apple.com/jo/rss"
let SERVER_IP = "https://\(SERVER_DOMAIN)"
var API=APIManager()
let LANGUAGE = "EN"

