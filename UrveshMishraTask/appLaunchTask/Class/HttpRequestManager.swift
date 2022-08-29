//
//  HttpRequestManager.swift
//  UrveshMishraTask
//
//  Created by Urvesh Mishra on 26/08/22.
//  Copyright © 2016 UrveshMishra. All rights reserved.

import UIKit
import Alamofire
import SVProgressHUD
import SystemConfiguration

//Encoding Type
let URL_ENCODING = URLEncoding.default
let JSON_ENCODING = JSONEncoding.default

//Web Service Result

public enum RESPONSE_STATUS : NSInteger
{
    case INVALID
    case VALID
    case MESSAGE
}
protocol UploadProgressDelegate
{
    func didReceivedProgress(progress:Float)
}

protocol DownloadProgressDelegate
{
    func didReceivedDownloadProgress(progress:Float,filename:String)
    func didFailedDownload(filename:String)
}

class HttpRequestManager
{
    static let sharedInstance = HttpRequestManager()
    let additionalHeader: HTTPHeaders = ["Content-Type": "application/json"]
    var responseObjectDic = Dictionary<String, AnyObject>()
    var URLString : String!
    var Message : String!
    var resObjects:AnyObject!
    var alamoFireManager = Alamofire.Session.default//Alamofire.SessionManager.default
    var delegate : UploadProgressDelegate?
    var downloadDelegate : DownloadProgressDelegate?
    // METHODS
    init()
    {
        alamoFireManager.session.configuration.timeoutIntervalForRequest = 1000 //seconds
        alamoFireManager.session.configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
    }
    
    //MARK:- Cancel Request
    func cancelAllAlamofireRequests(responseData:@escaping ( _ status: Bool?) -> Void)
    {
        alamoFireManager.session.getTasksWithCompletionHandler
            {
                dataTasks, uploadTasks, downloadTasks in
                dataTasks.forEach { $0.cancel() }
                uploadTasks.forEach { $0.cancel() }
                downloadTasks.forEach { $0.cancel() }
                responseData(true)
        }
    }
    
    //requestWithPostJsonParam
    func requestWithPostJsonParamWithFullURL( fullURL:String,
                                              parameters:NSDictionary,
                                              showLoader:Bool,
                                              completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            
            let strURL =  fullURL
            print("URL : \(strURL) \nParam :\( parameters) ")
            
            print("Header Param :\(additionalHeader)")
            alamoFireManager.request(strURL, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        if let dic = value as? NSDictionary {
                            let message = dic["message"] as? String ?? ""
                            let status = dic["status"] as? String ?? ""
                        }
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil, error as NSError?)
                        break
                    }
            }
        }
    }
    
    func requestWithPostJsonParam( service:String,
                                   parameters:NSDictionary,
                                   showLoader:Bool,
                                   isLoginMandatory:Bool = false,
                                   showTost : Bool = true,
                                   completionHandler:@escaping (_ responseDict: NSDictionary?, _ error: NSError?) -> Void)
    {
        if isConnectedToNetwork()
        {
            if(showLoader) { showLoaderHUD(strMessage: "") }
            
            let strURL = BASE_URL + service
            print("URL : \(strURL) \nParam :\( parameters) ")
            
            print("Header Param :\(additionalHeader)")
            
            alamoFireManager.request(strURL, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: additionalHeader)
                .responseJSON { response in
                    hideLoaderHUD()
                    print("Response \(response)")
                    switch(response.result)
                    {
                    case .success(let value):
                        if let dic = value as? NSDictionary {
                            let message = dic["message"] as? String ?? ""
                            let status = dic["status"] as? String ?? ""
                            
                            if status == "0" {
                                if showTost == true{
                                    UIApplication.shared.keyWindow?.rootViewController?.showAlert(message, message: "")
                                }
                            }
                        }
                        completionHandler(dictionaryOfFilteredBy(dict: (value as? NSDictionary)!), nil)
                        break
                    case .failure(let error):
                        completionHandler(nil, error as NSError?)
                        break
                    }
            }
        }
    }
    
    
    //MARK: GET
    func getRequest(service:String,
                    showLoader:Bool,
                    urlParam:String? = "",
                    responseData:@escaping  (_ error: NSError?,_ responseDict: Data?) -> Void)
    {
        if isConnectedToNetwork()
        {
            print("Header Param :\(additionalHeader)")
            let strURL = BASE_URL + service
            if showLoader {
                showLoaderHUD(strMessage: "")
            }
            alamoFireManager.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default).responseData { response in
                hideLoaderHUD()
                switch(response.result)
                {
                case .success:
                    responseData(nil, response.data)
                    break
                case .failure(let error):
                    responseData(error as NSError?, nil)
                    break
                }
            }
        }
    }
    
    //MARK: Convert InTo Json String
    func jsonToString(json: AnyObject) -> String{
        do {
            let data1 = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data1, encoding: String.Encoding.utf8)
            return convertedString!
        } catch let myJSONError {
            print(myJSONError)
            return ""
        }
    }
        
}
//MARK:-Check Internet connection
func isConnectedToNetwork() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    })
        else
    {
        return false
    }
    
    var flags : SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    let available =  (isReachable && !needsConnection)
    if(available)
    {
        return true
    }
    else
    {
        //showMessage(InternetNotAvailable)
        return false
    }
}
//MARK:- SwiftMessage
public func showLoaderHUD(strMessage:String)
{
    SVProgressHUD.setDefaultMaskType(.gradient)
    SVProgressHUD.setForegroundColor(#colorLiteral(red: 0.2431372549, green: 0.4078431373, blue: 0.9960784314, alpha: 1))
    //    SVProgressHUD.setBackgroundColor(UIColor.clear)
    if strMessage == "" {
        SVProgressHUD.show()
    }else{
        SVProgressHUD.show(withStatus: strMessage)
    }
}

public func hideLoaderHUD()
{
    
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
    }
    //    LoadingHud.dismissHUD()
}

func dictionaryOfFilteredBy(dict: NSDictionary) -> NSDictionary {
    
    let replaced: NSMutableDictionary = NSMutableDictionary(dictionary : dict)
    let blank: String = ""
    
    for (key, _) in dict
    {
        let object = dict[key] as AnyObject
        
        if (object.isKind(of: NSNull.self))
        {
            replaced[key] = blank as AnyObject?
        }
        else if (object is [AnyHashable: AnyObject])
        {
            replaced[key] = dictionaryOfFilteredBy(dict: object as! NSDictionary)
        }
        else if (object is [AnyObject])
        {
            replaced[key] = arrayOfFilteredBy(arr: object as! NSArray)
        }
        else
        {
            replaced[key] = "\(object)" as AnyObject?
        }
    }
    return replaced
}

func arrayOfFilteredBy(arr: NSArray) -> NSArray {
    
    let replaced: NSMutableArray = NSMutableArray(array: arr)
    let blank: String = ""
    
    for i in 0..<arr.count
    {
        let object = arr[i] as AnyObject
        
        if (object.isKind(of: NSNull.self))
        {
            replaced[i] = blank as AnyObject
        }
        else if (object is [AnyHashable: AnyObject])
        {
            replaced[i] = dictionaryOfFilteredBy(dict: arr[i] as! NSDictionary)
        }
        else if (object is [AnyObject])
        {
            replaced[i] = arrayOfFilteredBy(arr: arr[i] as! NSArray)
        }
        else
        {
            replaced[i] = "\(object)" as AnyObject
        }
        
    }
    return replaced
}
