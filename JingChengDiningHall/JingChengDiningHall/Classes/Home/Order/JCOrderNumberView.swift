//
//  JCOrderNumberView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderNumberView: UIView {

    // 背景
    lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "order_LeftCell_number_border_normal");
        return background;
    }();
    
    // 几人桌
    lazy var titelLabel: UILabel = {
        let titleLabel = UILabel();
        titleLabel.font = Font(size: 20/2);
        titleLabel.text = "2人桌";
        titleLabel.textColor = RGBWithHexColor(hexColor: 0x4c4c4c);
        titleLabel.backgroundColor = UIColor.clear;
        titleLabel.textAlignment = .center;
        return titleLabel;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加几人状态
        background.addSubview(titelLabel);
    }

    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置titleLabel的frame
        titelLabel.frame = bounds;
 
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
