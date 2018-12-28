//
//  APIManager.swift
//  FitCoin
//
//  Created by Shaheen Al-Habash on 8/26/18.
//  Copyright © 2018 Shaheen Al-Habash. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    fileprivate var _Session:URLSession
    //*******************************************************************************
    init(){
        //let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        //_Session = NSURLSession(configuration: config)
        _Session = URLSession.shared
    }
    //*******************************************************************************
    func getTopFreeApp (_ urlString:String, completion: @escaping (Int,String,[TopFreeApp]) -> Void ) {
        // make request
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let task = _Session.dataTask(with: request, completionHandler: {
            (rData, rResponse, rError) -> Void in
            
            var xError_code = 1
            var xError_message = "Unexpected error"
            var xlstTopFreeApp=[TopFreeApp]()
            
            do {
                if rError != nil {
                    xError_code = 1
                    xError_message = rError!.localizedDescription
                    throw MyError.apiError
                } else {
                    if let xJson = try  JSONSerialization.jsonObject(with: rData!, options: .allowFragments) as? JSONDictionary{
                        print(xJson)
                        
                        let xFeed = xJson["feed"] as? JSONDictionary
                        
                        let xEntry = xFeed!["entry"] as? JSONArray
                        if(xEntry != nil)
                        {
                            for  (_,iEntry) in xEntry!.enumerated() {
                                let xEntry = TopFreeApp(TopFreeApp: iEntry)
                                xlstTopFreeApp.append(xEntry)
                            }
                        }
                        
                        xError_code = 0
                        DispatchQueue.global(qos: .background).async {
                            DispatchQueue.main.async {
                                completion(xError_code,xError_message,xlstTopFreeApp)
                            }
                        }
                    }
                }
            } catch{
                print(error)
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        completion(xError_code,xError_message,xlstTopFreeApp)
                    }
                }
            }
        })
        task.resume()
    }
    //*******************************************************************************
    func createBodyWithParameters(_ parameters: [String: String]?, filePathKey: String,vSource:String,vImageKey:String, imageDataKey: Data, boundary: String) -> Data {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        var filename = ""
        var mimetype = ""
        
        switch filePathKey {
        case "jpg":
            filename = "\(vSource).\(filePathKey)"
            mimetype = "image/\(filePathKey)"
        default:
            filename = "\(vSource).\(filePathKey)"
            mimetype = "Document/\(filePathKey)"
        }
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(vImageKey)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        return body as Data
    }
    //*******************************************************************************
    func createBodyWithParameters(_ parameters: [String: String]?, boundary: String) -> Data {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        
        body.appendString("--\(boundary)--\r\n")
        return body as Data
    }
    //*****************************************************************
    public func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    //*******************************************************************************
}
//*******************************************************************************
//*******************************************************************************
extension NSMutableData {
    //*******************************************************************************
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
    //*******************************************************************************
}
//*******************************************************************************
//*******************************************************************************
