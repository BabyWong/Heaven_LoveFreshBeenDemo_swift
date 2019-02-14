//
//  RequestManager.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/15/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

public enum RequestMethods: String {
    case RequestMethodsPost = "post"
    case RequestMethodsGet = "get"
}

class RequestManager: AFHTTPSessionManager {

    static public let instence = RequestManager()
    class func shareManager() -> RequestManager {
        
        instence.requestSerializer.willChangeValue(forKey: "timeoutInterval")
        instence.requestSerializer.timeoutInterval = 30
        instence.requestSerializer.didChangeValue(forKey: "timeoutInterval")
        instence.responseSerializer = AFJSONResponseSerializer()
        instence.responseSerializer.acceptableContentTypes?.insert("application/json")
        instence.responseSerializer.acceptableContentTypes?.insert("text/json")
        instence.responseSerializer.acceptableContentTypes?.insert("text/javascript")
        instence.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return instence
    }
}

extension RequestManager {
    
    
    func requestFile(requestMethods: RequestMethods, URLString: String, parame: [String : Any]?, success: @escaping (_ result: Any?, _ code: String?, _ message: String?) -> (), failed: @escaping (_ error: Any?, _ message: String?) -> ())  {
        
        let successBlock = { (task: URLSessionDataTask, responseObject: Any?) in
            print("成功")
            let d = responseObject  as! [String : Any]?
            success(d?["data"],(d?["code"] as! String), (d?["message"] as! String))
        }
        
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            print("失败\(error)")
            failed(error, "网络传输失败")
        }
        
        if requestMethods == .RequestMethodsPost {
            post(URLString, parameters: parame, progress: { (Progress) in
                print("进度\(Progress)")
            }, success: successBlock, failure: failureBlock)
        }else {
            get(URLString, parameters: parame, progress: { (Progress) in
                print("进度\(Progress)")
            }, success: successBlock, failure: failureBlock)
        }
    }
    
    /// 请求数据
    ///
    /// - Parameters:
    ///   - requestMethods: 请求方式: post get
    ///   - URLString: 请求链接
    ///   - parame: 请求参数
    ///   - showHub: true 弹窗
    ///   - success: 请求成功回调
    ///   - failed: 请求失败回调
    func request(requestMethods: RequestMethods, URLString: String, parame: [String : Any]?, showHub:Bool, success: @escaping (_ result: ResponseDate) -> (), failed: @escaping (_ error: Any) -> ()) {
        
        let successBlock = { (task: URLSessionDataTask, responseObject: Any!) in
            let result = ResponseDate.mj_object(withKeyValues: responseObject) as ResponseDate
            if showHub && result.state != "1" {
                SVProgressHUD.showError(withStatus: result.message)
            }
            success(result)
        }
        
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            print("失败\(error)")
            if showHub {
                SVProgressHUD.showError(withStatus: "网络传输失败")
            }
            failed(error)
        }
        
        if requestMethods == .RequestMethodsPost {
            post(URLString, parameters: parame, progress: { (Progress) in
                print("进度\(Progress)")
            }, success: successBlock, failure: failureBlock)
        }else {
            get(URLString, parameters: parame, progress: { (Progress) in
                print("进度\(Progress)")
            }, success: successBlock, failure: failureBlock)
        }
    }
}

class ResponseDate: NSObject {
    /// 接口返回状态: 1 成功  else 失败
    @objc var state: String = "0"
    @objc var message: String = ""
    @objc var data: Any?
}
