//
//  TopFreeApp.swift
//  Top Free Apps
//
//  Created by Shaheen Al-Habash on 12/27/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import Foundation
class TopFreeApp {
    
    fileprivate var _Id:String
    fileprivate var _Name:String
    fileprivate var _Image53x:String
    fileprivate var _Image75x:String
    fileprivate var _Image100x:String
    fileprivate var _Summary:String
    fileprivate var _Price:String
    fileprivate var _Currency:String
    fileprivate var _ContentType:String
    fileprivate var _Rights:String
    fileprivate var _Title:String
    fileprivate var _Link:String
    fileprivate var _Artist:String
    fileprivate var _Category:String
    fileprivate var _ReleaseDate:String
    //Make a getter and setter
    
    var Id: String {
        set { _Id = newValue }
        get { return _Id }
    }
    var Name: String {
        set { _Name = newValue }
        get { return _Name }
    }
    var Image53x: String {
        set { _Image53x = newValue }
        get { return _Image53x }
    }
    var Image75x: String {
        set { _Image75x = newValue }
        get { return _Image75x }
    }
    var Image100x: String {
        set { _Image100x = newValue }
        get { return _Image100x }
    }
    var Summary: String {
        set { _Summary = newValue }
        get { return _Summary }
    }
    var Price: String {
        set { _Price = newValue }
        get { return _Price }
    }
    var Currency: String {
        set { _Currency = newValue }
        get { return _Currency }
    }
    var ContentType: String {
        set { _ContentType = newValue }
        get { return _ContentType }
    }
    var Rights: String {
        set { _Rights = newValue }
        get { return _Rights }
    }
    var Title: String {
        set { _Title = newValue }
        get { return _Title }
    }
    var Link: String {
        set { _Link = newValue }
        get { return _Link }
    }
    var Artist: String {
        set { _Artist = newValue }
        get { return _Artist }
    }
    var Category: String {
        set { _Category = newValue }
        get { return _Category }
    }
    var ReleaseDate: String {
        set { _ReleaseDate = newValue }
        get { return _ReleaseDate }
    }
    
    init(){
        _Id = ""
        _Name = ""
        _Image53x = ""
        _Image75x = ""
        _Image100x = ""
        _Price = ""
        _Currency = ""
        _Summary = ""
        _ContentType = ""
        _Rights = ""
        _Title = ""
        _Link = ""
        _Artist = ""
        _Category = ""
        _ReleaseDate = ""
    }
    
    init(TopFreeApp: AnyObject){
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["id"] as? JSONDictionary ,let xValue2 = xValue1["attributes"] as? JSONDictionary,let xValue3 = xValue2["im:id"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Id  = "\(xValue3)"
        }
        else
        {
            _Id = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:name"] as? JSONDictionary ,let xValue2 = xValue1["label"] , "\(xValue2)" != "NA", "\(xValue2)" != "<null>"{
            self._Name  = "\(xValue2)"
        }
        else
        {
            _Name = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:image"] as? JSONArray ,let xValue2 = xValue1[0] as? JSONDictionary,let xValue3 = xValue2["label"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Image53x  = "\(xValue3)"
        }
        else
        {
            _Image53x = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:image"] as? JSONArray ,let xValue2 = xValue1[1] as? JSONDictionary,let xValue3 = xValue2["label"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Image75x  = "\(xValue3)"
        }
        else
        {
            _Image75x = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:image"] as? JSONArray ,let xValue2 = xValue1[2] as? JSONDictionary,let xValue3 = xValue2["label"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Image100x  = "\(xValue3)"
        }
        else
        {
            _Image100x = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:price"] as? JSONDictionary ,let xValue2 = xValue1["attributes"] as? JSONDictionary,let xValue3 = xValue2["amount"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Price  = "\(xValue3)"
        }
        else
        {
            _Price = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:price"] as? JSONDictionary ,let xValue2 = xValue1["attributes"] as? JSONDictionary,let xValue3 = xValue2["currency"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Currency  = "\(xValue3)"
        }
        else
        {
            _Currency = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["summary"] as? JSONDictionary ,let xValue2 = xValue1["label"], "\(xValue2)" != "NA", "\(xValue2)" != "<null>"{
            self._Summary  = "\(xValue2)"
        }
        else
        {
            _Summary = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:contentType"] as? JSONDictionary ,let xValue2 = xValue1["attributes"] as? JSONDictionary,let xValue3 = xValue2["label"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._ContentType  = "\(xValue3)"
        }
        else
        {
            _ContentType = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["rights"] as? JSONDictionary ,let xValue2 = xValue1["label"], "\(xValue2)" != "NA", "\(xValue2)" != "<null>"{
            self._Rights  = "\(xValue2)"
        }
        else
        {
            _Rights = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["title"] as? JSONDictionary ,let xValue2 = xValue1["label"], "\(xValue2)" != "NA", "\(xValue2)" != "<null>"{
            self._Title  = "\(xValue2)"
        }
        else
        {
            _Title = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["link"] as? JSONDictionary ,let xValue2 = xValue1["attributes"] as? JSONDictionary,let xValue3 = xValue2["href"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Link  = "\(xValue3)"
        }
        else
        {
            _Link = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:artist"] as? JSONDictionary ,let xValue2 = xValue1["label"], "\(xValue2)" != "NA", "\(xValue2)" != "<null>"{
            self._Artist  = "\(xValue2)"
        }
        else
        {
            _Artist = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["category"] as? JSONDictionary ,let xValue2 = xValue1["attributes"] as? JSONDictionary,let xValue3 = xValue2["label"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._Category  = "\(xValue3)"
        }
        else
        {
            _Category = ""
        }
        if let xJSONDictionary = TopFreeApp as? JSONDictionary ,
            let xValue1 = xJSONDictionary["im:releaseDate"] as? JSONDictionary ,let xValue2 = xValue1["attributes"] as? JSONDictionary,let xValue3 = xValue2["label"], "\(xValue3)" != "NA", "\(xValue3)" != "<null>"{
            self._ReleaseDate  = "\(xValue3)"
        }
        else
        {
            _ReleaseDate = ""
        }
    }
}
