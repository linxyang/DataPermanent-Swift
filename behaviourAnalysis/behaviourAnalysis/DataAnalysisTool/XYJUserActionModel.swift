//
//  XYJUserActionModel.swift
//  behaviourAnalysis
//
//  Created by xyj on 2017/3/6.
//  Copyright © 2017年 xyj. All rights reserved.
//  用户形为模型

import UIKit
import FMDB

class XYJUserActionModel: NSObject {

    /// 用户编码
    var user_code = ""
    /// 平台id
    var platform_type = "1" // ios = 1   android = 2
    /// 场景编码
    var action_scene = ""
    /// 操作前页面编码
    var old_pagecode = ""
    /// 操作后页面编码
    var new_pagecode = ""
    /// 操作时间
    var created_time = ""
    /// 描述
    var remark = ""
    /// 定位城市
    var city = ""
    /// 时长
    var time_length = "0.0"
    
    
    /// 进入时间
    var time_in = ""
    /// 离开时间
    var time_out = ""
    
    
    func currenFormatTime() -> String {
        
        let formatter = DateFormatter.init()
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS";
        return formatter.string(from: Date())
    }
    
    
    func timeLengthBetween(earlyTime:String, laterTime: String) -> String {
        
        let formatter = DateFormatter.init()
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS";
        
        guard let date1 = formatter.date(from: earlyTime) else { return "0.00" }
        guard let date2 = formatter.date(from: laterTime) else { return "0.00" }
        
        let tiemLenght = date2.timeIntervalSince(date1)
        
        return String.init(format: "%.2f", tiemLenght)
    }
    
}
