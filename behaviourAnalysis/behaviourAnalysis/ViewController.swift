//
//  ViewController.swift
//  behaviourAnalysis
//
//  Created by xyj on 2017/3/6.
//  Copyright © 2017年 xyj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = XYJUserActionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        XYJDataAnalysisManager.shareManager.getUserActionListJson()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.time_in = model.currenFormatTime()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        model.time_out = model.currenFormatTime()
        model.time_length = model.timeLengthBetween(earlyTime: model.time_in, laterTime: model.time_out)
        XYJDataBaseManager.shareManager.insertDataWith(actionListModel: model)
    }
    
    @IBAction func createTable(_ sender: UIButton) {
        
        _ = XYJDataBaseManager.shareManager
    }
    
    @IBAction func insertData(_ sender: UIButton) {
        
        XYJDataBaseManager.shareManager.insertDataWith(actionListModel: model)
    }
    
    @IBAction func deleteAllData(_ sender: UIButton) {
        
        XYJDataBaseManager.shareManager.deleteAllData()
    }
    
    
    @IBAction func getAllData(_ sender: UIButton) {
        
        let array =  XYJDataBaseManager.shareManager.getActionListData()
        print(array)
    }
    
    
    /// 下一页
    
    @IBAction func nextPage(_ sender: UIBarButtonItem) {
        
        navigationController?.pushViewController(TestViewController(), animated: true)
        
        
    }
    
}

