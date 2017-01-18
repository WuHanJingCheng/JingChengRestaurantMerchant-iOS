//
//  JCHintLabel.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/11.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCHintLabel: UIView {

    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage.imageWithName(name: "hint_icon");
        return icon;
    }();
    
    // 提示文本
    private lazy var textLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 24/2);
        label.textAlignment = .left;
        return label;
    }();
    
    var text: String? {
        didSet {
            // 获取可选类型中的数据
            guard let text = text else {
                return;
            }
            
            textLabel.text = text;
            
            // 更新frame
            setNeedsLayout();
            layoutIfNeeded();
        }
    }
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加icon
        addSubview(icon);
        
        // 添加提示文本
        addSubview(textLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        
        // 设置icon的frame
        let iconX = realValue(value: 0);
        let iconY = realValue(value: 0);
        let iconW = realValue(value: 30/2);
        let iconH = realValue(value: 30/2);
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
        
        // 设置提示文本的frame
        let textLabelW = calculateWidth(title: textLabel.text ?? "", fontSize: 24/2);
        let textLabelH = realValue(value: 24/2);
        let textLabelX = icon.frame.maxX + realValue(value: 15/2);
        let textLabelY = (height - textLabelH)/2;
        textLabel.frame = CGRect(x: textLabelX, y: textLabelY, width: textLabelW, height: textLabelH);
        
        
    }
}
