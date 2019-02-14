//
//  LoginModel.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/22/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class LoginModel: NSObject {
    
    @objc var email: String = ""
    @objc var headPic: String = ""
    @objc var telephone: String?
    @objc var customerId: String?
    @objc var token: String?
    @objc var fullName: String?
    
    class func requestLogin(email: String, password: String, _ completion:@escaping (_ response: ResponseDate, _ loginModel: LoginModel)-> ()) {
        RequestManager.shareManager().request(requestMethods: .RequestMethodsPost, URLString: API_LoginUrl, parame: ["email":email, "password": password], showHub:true, success: { (result) in
            let loginM = LoginModel.mj_object(withKeyValues: result.data) as LoginModel
            completion(result, loginM)
        }) { (error) in
            print("\(String(describing: error))")
        }
    }
    
    class func requestOutLogin(_ completion:@escaping (_ response: ResponseDate)-> ()) {
        RequestManager.shareManager().request(requestMethods: .RequestMethodsPost, URLString: API_OutLoginUrl, parame: ["token":""], showHub: true, success: { (ResponseDate) in
            
        }) { (error) in
            
        }
    }

}
