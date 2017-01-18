//
//  JCSubMenuListAddCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/3.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCSubMenuListAddCell: UICollectionViewCell {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "submenulist_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage.imageWithName(name: "submenulist_addbtn");
        icon.isUserInteractionEnabled = true;
        return icon;
    }();
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        contentView.addSubview(background);
        
        // 添加icon
        background.addSubview(icon);
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置background 的frame
        background.frame = bounds;
        
        
        // 设置icon的frame
        let iconW = realValue(value: 84/2);
        let iconH = iconW;
        let iconX = (width - iconW)/2;
        let iconY = (height - iconH)/2;
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
