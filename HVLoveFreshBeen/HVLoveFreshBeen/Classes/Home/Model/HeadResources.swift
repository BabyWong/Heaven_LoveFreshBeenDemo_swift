//
//  HeadResources.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 2/22/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class HeadResources: NSObject {
    
    @objc var msg: String?
    @objc var reqid: String?
    @objc var data: HeadData?
    
    class func loadHomeHeadData(_ completion:(_ data: HeadResources?, _ error: NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "首页焦点按钮", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as! NSDictionary
            let headResourcesDataModel = HeadResources.mj_object(withKeyValues: dict)
            completion(headResourcesDataModel, nil)
        }
    }

    override func mj_keyValuesDidFinishConvertingToObject() {
        data?.focus = Activities.mj_objectArray(withKeyValuesArray: data?.focus) as? [Activities]//.copy()
        data?.icons = Activities.mj_objectArray(withKeyValuesArray: data?.icons) as? [Activities]//.copy()
        data?.activities = Activities.mj_objectArray(withKeyValuesArray: data?.activities) as? [Activities]
    }
}

class HeadData: NSObject {
    @objc var focus: [Activities]? = [Activities]()
    @objc var icons: [Activities]? = [Activities]()
    @objc var activities: [Activities]? = [Activities]()
}


class Activities: NSObject {
    @objc var id: String?
    @objc var name: String?
    @objc var img: String?
    @objc var topimg: String?
    @objc var jptype: String?
    @objc var trackid: String?
    @objc var mimg: String?
    @objc var customURL: String?
}

