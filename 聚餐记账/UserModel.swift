//
//  UserModel.swift
//  聚餐记账
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation


class UserModel {
    var userId = 0
    var name = "noOne"
    var shouldGetMoney:Float = 0.0

    var isEaten = true
    var paiedMoney:Float = 0.0

    init(userId: Int, name: String) {
        self.userId = userId
        self.name = name
        self.shouldGetMoney = 0
        self.isEaten = true
        self.paiedMoney = 0
    }
}

