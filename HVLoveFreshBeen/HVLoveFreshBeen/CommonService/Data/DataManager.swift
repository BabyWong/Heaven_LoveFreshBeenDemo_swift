//
//  DataManager.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/28/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

public enum DataManager_ENUM_TYPE {
    case DataManager_ENUM_TYPE_SAVE
    case DataManager_ENUM_TYPE_GET
    case DataManager_ENUM_TYPE_REMOVE
}

class DataManager: NSObject {
    
    static let instense: DataManager = DataManager()
    class func shareDataManager() -> DataManager {
        return instense
    }
    
    open func tokenUpdate( type: DataManager_ENUM_TYPE, value:String?) {
        if type == .DataManager_ENUM_TYPE_SAVE {
            DataConfig.shareDataConfig().hv_setObject(forKey: "token", valueAny: value)
        }else if type == .DataManager_ENUM_TYPE_GET {
        }else if type == .DataManager_ENUM_TYPE_REMOVE {
            DataConfig.shareDataConfig().removeObject(ForKey: "token")
        }
    }
    open func getToken() -> String {
        return DataConfig.shareDataConfig().hv_object(forKey: "token") as! String
    }

}
