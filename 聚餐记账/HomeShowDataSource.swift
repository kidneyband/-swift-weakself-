//
//  File.swift
//  聚餐记账
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation

class HomeShowDataSource {
    var index = 0
    var isChecked = false
    init(index: Int, isChecked: Bool){
        self.index = index
        self.isChecked = isChecked
    }
}