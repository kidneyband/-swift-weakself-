//
//  HomeTableViewCell.swift
//  聚餐记账
//
//  Created by apple on 15/5/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
let ScreenSize = UIScreen.mainScreen().bounds.size

class HomeTableViewCell: UITableViewCell {
    
    var label = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.blackColor()
        label.text = "未结账"
        self.contentView.addSubview(label)

    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRectMake(ScreenSize.width - 90, 17.5, 100, 15)

    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
