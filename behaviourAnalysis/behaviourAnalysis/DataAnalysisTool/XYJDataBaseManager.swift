//
//  XYJDataBaseManager.swift
//  behaviourAnalysis
//
//  Created by xyj on 2017/3/6.
//  Copyright © 2017年 xyj. All rights reserved.
//  数据库操作

import UIKit
import FMDB

class XYJDataBaseManager: NSObject {

    /// 单例对象
    static let shareManager = XYJDataBaseManager.init()
    
    /// 数据库
    var _db: FMDatabase?
    
    override init() {
        super.init()
        let path = NSHomeDirectory()+"/Library/Caches/UserActionData.sqlite"
        _db = FMDatabase.init(path: path)
        
        _db!.open()
        let sql = "create table if not exists userActionData_table(id integer primary key autoincrement, user_code text, platform_type text, action_scene text, old_pagecode text, new_pagecode text, created_time text, remark text, city text, time_length integer,  reserve1 text, reserve2 text)" // 预留2个字段
        let result = _db!.executeUpdate(sql, withArgumentsIn: nil)
        if result {
            print("创建表格 === 成功:UserActionData.sqlite")
        }
        _db!.close()
    }
    
    /// 插入一条数据
    func insertDataWith(actionListModel: XYJUserActionModel) -> Void {
        
        let flag = _db!.open()
        if !flag { return }
        
        let sql = String.init(format: "INSERT INTO userActionData_table ('%@','%@','%@','%@','%@','%@','%@','%@','%@' ) VALUES (?,?,?,?,?,?,?,?,?)",
            "user_code",
            "platform_type",
            "action_scene",
            "old_pagecode",
            "new_pagecode",
            "created_time",
            "remark",
            "city",
            "time_length")
        
        let isSuccess = _db!.executeUpdate(sql, withArgumentsIn:
            [actionListModel.user_code,
            actionListModel.platform_type,
            actionListModel.action_scene,
            actionListModel.old_pagecode,
            actionListModel.new_pagecode,
            actionListModel.created_time,
            actionListModel.remark,
            actionListModel.city,
            actionListModel.time_length])
        if isSuccess {
            print("插入数据 === 成功")
        } else {
            print("插入数据 === 失败")
        }
        _db!.close()
    }
    
    
    /// 删除所有数据
    func deleteAllData() -> Void {
        
        let flag = _db!.open()
        if !flag { return }
        
        let sql = "delete from userActionData_table"
        let isSuccess = _db!.executeUpdate(sql, withArgumentsIn: nil)
        if isSuccess {
            print("清空形为数据表 === 成功")
        } else {
            print("清空形为数据表 === 失败")
        }
        _db!.close()
    }
    
    /// 获取所有要发送的数据
    func getActionListData() -> [[String:String]] {
        
        let flag = _db!.open()
        if !flag { return []}
        
        guard let resultSet = _db!.executeQuery("select * from userActionData_table", withArgumentsIn: nil) else { return [] }
        
        var actionListM = [[String:String]]()
        while resultSet.next() {
        
            var dict = [String:String]()
            dict["user_code"] = resultSet.string(forColumn: "user_code")
            dict["platform_type"] = resultSet.string(forColumn: "platform_type")
            dict["action_scene"] = resultSet.string(forColumn: "action_scene")
            dict["old_pagecode"] = resultSet.string(forColumn: "old_pagecode")
            dict["new_pagecode"] = resultSet.string(forColumn: "new_pagecode")
            dict["created_time"] = resultSet.string(forColumn: "created_time")
            dict["remark"] = resultSet.string(forColumn: "remark")
            dict["city"] = resultSet.string(forColumn: "city")
            dict["time_length"] = resultSet.string(forColumn: "time_length")
            actionListM.append(dict)
        }
        
        _db!.close()
        
        if actionListM.count > 0 {
            print("获取形为数据表 === 成功")
        } else {
            print("获取形为数据表 === 失败")
        }
        return actionListM.count > 0 ? actionListM : []
    }
    
    
    
}
