//
//  XYJDataAnalysisManager.swift
//  behaviourAnalysis
//
//  Created by xyj on 2017/3/6.
//  Copyright © 2017年 xyj. All rights reserved.
//

import UIKit


class XYJDataAnalysisManager: NSObject {

    /// 单例对象
    static let shareManager = XYJDataAnalysisManager()
    
    /// 定时器
    var timer: Timer?
    /// 定时器时间计数
    var timeCount = 0
    /// 每隔几分钟一次 ---- 默认5分钟
    var minuteCount: Int = 5
    /// 要发送的数据
    var actionListM: Array<Any>?
    
    
    
    override init() {
        super.init()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(XYJDataAnalysisManager.timeTick), userInfo: nil, repeats: true)
            timer?.fireDate = Date.distantFuture
            RunLoop.current.add(timer!, forMode: .commonModes)
        }
    }
    
    
    /// 启动形为分析数据上传功能
    func startSendBehaviourAnalysis(preTime: Int) -> Void {
        
        minuteCount = preTime
        timer?.fireDate = Date()
    }
    
    /// 关闭形为分析数据上传功能
    func startSendBehaviourAnalysis() -> Void {
        
        timer?.fireDate = Date.distantFuture
        timer?.invalidate()
    }
    
    
    /// 定时器任务
    func timeTick() -> Void {
        
        timeCount = timeCount + 1
        
        if timeCount % (self.minuteCount * 60) == 0 {
            // 在这里发送形为分析数据，成功后清除表单
            
        }
        
    }
    
    
    /// 返回json数据
    ///
    /// - Returns: 形为分析的json字符串
    func getUserActionListJson() -> String {
        
        let actionArray = XYJDataBaseManager.shareManager.getActionListData()
        
        guard let data = try? JSONSerialization.data(withJSONObject: actionArray, options: JSONSerialization.WritingOptions.prettyPrinted) else { return "" }
        let jsonString = String.init(data: data, encoding: .utf8)
        return jsonString ?? ""
    }
    
}
