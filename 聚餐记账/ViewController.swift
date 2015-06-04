//
//  ViewController.swift
//  聚餐记账
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var showArray = [HomeShowDataSource]()

    var totalArray = [Array<UserModel>]()

    var userArray = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化用户数组
        userArray = creatArrayWithNum(1).first!
//        userArray = [userModel0, userModel1, userModel2, userModel3, userModel4]
        
        //初始化首页显示数据
        var showModel0 = HomeShowDataSource(index: 0, isChecked: false)
        var showModel1 = HomeShowDataSource(index: 1, isChecked: false)
        var showModel2 = HomeShowDataSource(index: 2, isChecked: false)
        var showModel3 = HomeShowDataSource(index: 3, isChecked: false)
        var showModel4 = HomeShowDataSource(index: 4, isChecked: false)
        var showModel5 = HomeShowDataSource(index: 5, isChecked: false)
        var showModel6 = HomeShowDataSource(index: 6, isChecked: false)
        var showModel7 = HomeShowDataSource(index: 7, isChecked: false)
        var showModel8 = HomeShowDataSource(index: 8, isChecked: false)
        var showModel9 = HomeShowDataSource(index: 9, isChecked: false)
        
        showArray = [showModel0, showModel1, showModel2, showModel3, showModel4, showModel5, showModel6, showModel7, showModel8, showModel9]
        
        totalArray = creatArrayWithNum(10)
//        for (var i = 0; i < 10; i++){
//        totalArray.append(userArray)
//        }
        //添加结算按钮
        let checkBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        checkBtn.backgroundColor = UIColor.whiteColor()
        checkBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        checkBtn.setTitle("结算", forState: UIControlState.Normal)
        checkBtn.frame = CGRectMake(0, 0, 60, 44)
        checkBtn.addTarget(self, action: "checkoutBaby", forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarbuttonItem = UIBarButtonItem(customView: checkBtn)
        self.navigationItem.rightBarButtonItem = rightBarbuttonItem
        
        title = "首页"
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    func creatArrayWithNum(number: Int)->([Array<UserModel>]){
        var resultArray =  [Array<UserModel>]()
        var tempArray = [UserModel]()
        for (var i = 0; i < number; i++){
            //        创建4个用户模型
            var userModel0 = UserModel(userId: 0, name: "陈亚军")
            var userModel1 = UserModel(userId: 1, name: "余帆")
            var userModel2 = UserModel(userId: 2, name: "高钢云")
            var userModel3 = UserModel(userId: 3, name: "黄亮")
            var userModel4 = UserModel(userId: 4, name: "俞家雪")
            tempArray = [userModel0, userModel1, userModel2, userModel3, userModel4]
            resultArray.append(tempArray)

        }
        return resultArray
    
    }
    
    
    func checkoutBaby(){
        
        var ansysArr = userArray
        //将大数组里面每一个小数组拆出来
        for (var i = 0; i < ansysArr.count; i++){
            
            var shouldGetMoney:Float = 0.0
            for tempArray in totalArray{
                let model = tempArray[i]
                shouldGetMoney += model.shouldGetMoney
        }
            ansysArr[i].shouldGetMoney = shouldGetMoney
        }
    
        //展示结果
        for model in ansysArr{
            println("\(model.name)应该得到\(model.shouldGetMoney)")

        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "reuserCellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeTableViewCell
        if cell == nil{
            cell = HomeTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.textLabel?.text = "第\(indexPath.row)天"
        var model = showArray[indexPath.row]
        if model.isChecked == false{
            cell?.label.text = "未结算"
        }else{
            cell?.label.text = "已结算"
        }
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return showArray.count    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    func appendResultArray(callbackArray: [UserModel], indexPath: NSIndexPath)->Void{
        println("调用了一次回调，更换了\(indexPath.row)项数组")
        //        totalArray.append
        showArray[indexPath.row].isChecked = true
        totalArray[indexPath.row] = callbackArray

        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("使用了\(indexPath.row)项数组")

        
    var vc = DetailTableViewController()
        vc.indexPath = indexPath
        vc.userArray = totalArray[indexPath.row]
//        vc.initWithCloser(appendResultArray)
        vc.myclosure = appendResultArray
//        navigationController?.showViewController(vc, sender: self)
        navigationController?.pushViewController(vc, animated: true)
    }
//    func tableView(UI


}

