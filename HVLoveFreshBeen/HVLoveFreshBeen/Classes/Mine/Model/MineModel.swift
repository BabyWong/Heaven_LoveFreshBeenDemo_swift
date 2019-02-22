//
//  MineModel.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/10/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class MineModel: NSObject {
    
    @objc var code: Int = -1
    @objc var msg: String?
    @objc var reqid: String?
    @objc var data: MineData?
    
    class func loadMineData(_ completion:(_ data: MineModel?, _ error: Error?) -> ()) {
        let path = Bundle.main.path(forResource: "Mine", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
            let dataModel = MineModel.mj_object(withKeyValues: dict)
            completion(dataModel, nil)
        }
    }
}

class MineData: NSObject {
    @objc var has_new: Int = -1
    @objc var has_new_user: Int = -1
    @objc var availble_coupon_num = 0
}
