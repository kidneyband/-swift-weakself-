//
//  DetailTableViewCell.swift
//  聚餐记账
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell, UITextFieldDelegate {

    var indexPath = NSIndexPath()
    
    var model: UserModel = UserModel(userId: 0, name: "陈亚军"){
        willSet{
        
        }didSet{
            textLabel?.text = "\(model.name)"
            if model.isEaten{
                checkBox.selected = true
            }else{
                checkBox.selected = false
            }
            paidLabel.text = "\(model.paiedMoney)"
        }
    }
    
    var myClosure: ((callBackModel:  UserModel, indexPath: NSIndexPath, changeIsEaten: Bool)->Void)!
    
    var paidLabel = UITextField()
    
    var checkBox = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.None
        
        paidLabel.font = UIFont.systemFontOfSize(14)
        paidLabel.layer.borderColor = UIColor.blackColor().CGColor
        paidLabel.layer.borderWidth = 1
        paidLabel.text = "\(model.paiedMoney)"
        paidLabel.keyboardType = UIKeyboardType.NumberPad
        paidLabel.delegate = self
        contentView.addSubview(paidLabel)
        
        checkBox.titleLabel?.font = UIFont.systemFontOfSize(11)
        checkBox.setTitle("没吃", forState: UIControlState.Normal)
        checkBox.setTitle("吃了", forState: UIControlState.Selected)
        checkBox.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        checkBox.setTitleColor(UIColor.blackColor(), forState: UIControlState.Selected)
        checkBox.addTarget(self, action: "checkIsEatten:", forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(checkBox)
        
        
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        paidLabel.frame = CGRectMake(ScreenSize.width - 90, 11, 80, 20)
        checkBox.frame = CGRectMake(ScreenSize.width - 140, 17, 30, 10)
    }
    
    
    
    func checkIsEatten(sender: UIButton){
        sender.selected = !sender.selected
        model.isEaten = !sender.selected
        model.paiedMoney = paidLabel.text!.floatValue
        //调用闭包
        if myClosure != nil{
            myClosure(callBackModel: model, indexPath: indexPath, changeIsEaten: true)
        }
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        model.paiedMoney = paidLabel.text!.floatValue
        //调用闭包
        if myClosure != nil{
            myClosure(callBackModel: model, indexPath: indexPath, changeIsEaten: false)
        }
            }
    
}

