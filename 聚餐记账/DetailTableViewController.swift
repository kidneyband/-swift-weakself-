//
//  DetailTableViewController.swift
//  聚餐记账
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

typealias closure = (callbackArray: [UserModel], indexPath: NSIndexPath)->Void

class DetailTableViewController: UITableViewController {
    
    var myclosure :closure?
    
    var indexPath = NSIndexPath()
    
    var checkThis = UIButton()

    var userArray = [UserModel]()
    
//    func initWithCloser(passClosure: closure?){
//    var myclosure: closure?
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        checkThis.setTitle("结算今天", forState: UIControlState.Normal)
        checkThis.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        checkThis.backgroundColor = UIColor.whiteColor()
        checkThis.frame = CGRectMake(0, 0, ScreenSize.width, 50)
        checkThis.addTarget(self, action: "checkThisBaby", forControlEvents: UIControlEvents.TouchUpInside)
        tableView.tableFooterView = checkThis

        title = "账目细节"
        tableView.reloadData()
        
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return userArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? DetailTableViewCell
        if cell == nil{
        cell = DetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }

        
        cell!.model = userArray[indexPath.row]
        cell!.indexPath = indexPath
        cell!.myClosure = {[weak self](callBackModel: UserModel, indexPath: NSIndexPath, changeIsEaten: Bool)->Void in
            
            if let strongSelf = self{
            strongSelf.userArray[indexPath.row] = callBackModel
            if changeIsEaten{
            strongSelf.userArray[indexPath.row].isEaten = !strongSelf.userArray[indexPath.row].isEaten
                }
        }
            
    }
        return cell!

    }
    
    
    func checkThisBaby(){
        view.endEditing(true)
        
        //在这里将钱平摊
        let counts = userArray.count
        var caculateArray = [UserModel]()
        
        //多少人吃饭
        var eatCount = 0
        for model in userArray{
            if model.isEaten{
                eatCount++
            }
        
        }
        
        println("有\(eatCount)人吃饭")
        
        var todayPaidMoney:Float = 0.0
        
        
        //遍历数组，获得钱数
            for tempModel in userArray{

            todayPaidMoney += tempModel.paiedMoney
            
        }
        
        
        var averageMoney = todayPaidMoney / Float(eatCount)

        for (var i = 0; i < userArray.count; i++){
            if userArray[i].isEaten == true{
                userArray[i].shouldGetMoney = userArray[i].paiedMoney - averageMoney
            }
        }
        
        //调用闭包
        //将数组传出去
        if (myclosure != nil){
            myclosure!(callbackArray: userArray, indexPath: indexPath)
        }
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    

    deinit{
    println("内存销毁了")
    }
    
    
}


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

