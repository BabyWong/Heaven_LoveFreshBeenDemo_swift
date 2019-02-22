//
//  DataConfig.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/24/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

public enum ENUM_DataConfig_TYPE {
    case ENUM_DataConfig_TYPE_NONE
    case ENUM_DataConfig_TYPE_INT
    case ENUM_DataConfig_TYPE_BOOL
    case ENUM_DataConfig_TYPE_FLOAT
    case ENUM_JPConfig_TYPE_STRING
    case ENUM_JPConfig_TYPE_LONG
}

let JPConfig_DATABASE_NAME = "JPConfig.db"
let JPConfig_V2_TABLE_NAME = "jpconfig"

let JPConfig_VALUE_TYPE_INT = "int"
let JPConfig_VALUE_TYPE_BOOL = "bool"
let JPConfig_VALUE_TYPE_FLOAT = "float"
let JPConfig_VALUE_TYPE_STRING = "string"
let JPConfig_VALUE_TYPE_LONG = "long"

class DataConfig: NSObject {
    
    static public let instence = DataConfig()
    class func shareDataConfig() -> DataConfig {
        return instence
    }
    var dpPointer: FMDatabase = FMDatabase()
    override init() {
        super.init()
        let documentPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let rs = JPConfig_DATABASE_NAME.components(separatedBy: ".")
        let realPath = "\(documentPath)/\(JPConfig_DATABASE_NAME)"
        let sourcePath = Bundle.main.path(forResource: rs[0], ofType: rs[1])
        let fileManag = FileManager.default
        if !(fileManag.fileExists(atPath: realPath)) {
            do {
                try fileManag.copyItem(atPath: sourcePath!, toPath: realPath)
            }catch {
                print("复制路径失败")
            }
        }
        print("\n\n复制路径成功: \(realPath)\n")
        dpPointer = FMDatabase.init(path: realPath)
    }
    
    /// 查表取值 查
    ///
    /// - Parameter forKey: 取值的key
    /// - Returns: 取到的值
    func hv_object(forKey:String) -> Any? {
        
        self.open()
        var object: Any?
        let sql = "select * from \(JPConfig_V2_TABLE_NAME) where key = '\(forKey)'"
        let rs:FMResultSet = dpPointer.executeQuery(sql, withArgumentsIn: []) ?? FMResultSet()
        while rs.next() {
            print(rs)
            let type = rs.object(forColumnIndex: 1)
            object = rs.object(forColumn: "value_\(type ?? "string")")
        }
        rs.close()
        self.close()
        return object ?? NSNull()
    }
    
    /// 增 改
    ///
    /// - Parameters:
    ///   - forKey: 写入的Key
    ///   - value: 写入的值
    func hv_setObject(forKey: String, valueAny: Any?) {
        var type: ENUM_DataConfig_TYPE = .ENUM_DataConfig_TYPE_NONE
        let valueA:Any = valueAny ?? NSNull.init()
        
        if valueA is NSNumber {
            
            let t = (valueA) as! String
            let tt =  (t.data(using: String.Encoding.utf8))?.base64EncodedString()
            print("\(t)==\(String(describing: tt))")
            if tt == "c" {
                type = .ENUM_DataConfig_TYPE_BOOL
            }else if tt == "f"
            {
                type = .ENUM_DataConfig_TYPE_FLOAT
            }else if tt == "i"
            {
                type = .ENUM_DataConfig_TYPE_INT
            }
            else if tt == "q"
            {
                type = .ENUM_JPConfig_TYPE_LONG
            }else {
                type = .ENUM_JPConfig_TYPE_LONG
            }
        }else if  valueA is String || valueA is NSString {
            type = .ENUM_JPConfig_TYPE_STRING
        }else if valueA is NSNull  {
            type = .ENUM_JPConfig_TYPE_STRING
        }
        let sql:String
        let type001: String = objectType(typeStr: getTypeString(type: type)) as String
        let type01: String = getTypeString(type: type)
        if existObject(ForKey: forKey) {
            sql = "update \(JPConfig_V2_TABLE_NAME) set \(type001) = '\(valueA)' WHERE key = '\(forKey)'"
        }else {
            sql = "insert into \(JPConfig_V2_TABLE_NAME) (key, objectType, \(type001)) VALUES ('\(forKey)','\(type01)','\(valueA)')"
            print(sql)
        }
        self.open()
        dpPointer.executeUpdate(sql, withArgumentsIn: [])
        self.close()
    }
    
    /// 删 对应的key
    ///
    /// - Parameter ForKey: 需要删除的key
    func removeObject(ForKey: String) {
        let sql = "delete from \(JPConfig_V2_TABLE_NAME) where key = '\(ForKey)'"
        self.open()
        dpPointer.executeUpdate(sql, withArgumentsIn: [])
        self.close()
    }
    
    func getTypeString(type: ENUM_DataConfig_TYPE) -> String {
        var ret: String = "string"
        switch type {
        case .ENUM_DataConfig_TYPE_INT:
            ret = JPConfig_VALUE_TYPE_INT
            break
        case .ENUM_DataConfig_TYPE_BOOL:
            ret = JPConfig_VALUE_TYPE_BOOL
            break
        case .ENUM_DataConfig_TYPE_FLOAT:
            ret = JPConfig_VALUE_TYPE_FLOAT
            break
        case .ENUM_JPConfig_TYPE_STRING:
            ret = JPConfig_VALUE_TYPE_STRING
            break
        default: break
        }
        return ret
    }
    
    func objectType(typeStr: String) -> String {
        return "value_\(typeStr)"
    }
    
    func existObject(ForKey : String) -> Bool {
        let res = self.hv_object(forKey: ForKey)
        if res is NSNull  {
            return false
        }
        return true
        
    }
    
    // 创建表
    func createTable() {
        
        // 1.编写SQL语句
        // id: 主键  name和age是字段名
        let sql = "CREATE TABLE IF NOT EXISTS T_Person( \n" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
            "name TEXT, \n" +
            "age INTEGER \n" +
        "); \n"
        
        // 2.执行SQL语句
        // 注意点: 在FMDB中除了查询意外, 都称之为更新
        if dpPointer.executeUpdate(sql, withParameterDictionary: (AnyObject.self as AnyObject) as! [AnyHashable : Any]){
            print("创建表成功")
        }else{
            print("创建表失败")
        }
    }
    
    /// 打开图表
    func open() {
        if dpPointer.open() {
//            print("打开数据库成功")
        }else {
//          createTable()
        }
    }
    
    /// 关闭图表
    func close() {
        dpPointer.close()
    }
    
    /// 删
    func clear() {
        self.open()
        dpPointer.executeUpdate("DELETE FROM \(JPConfig_V2_TABLE_NAME)", withArgumentsIn: [])
        self.close()
    }
}
