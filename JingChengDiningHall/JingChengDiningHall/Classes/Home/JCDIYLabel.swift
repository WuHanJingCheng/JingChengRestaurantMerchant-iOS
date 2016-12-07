//
//  JCDIYLabel.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/19.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDIYLabel: UIView {

    // 标题
    lazy var textLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x666666);
        label.textAlignment = .left;
        return label;
    }();
    
    // 标题详情
    lazy var textDetailLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加标题
        addSubview(textLabel);
        
        //  添加标题详情
        addSubview(textDetailLabel);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置textLabel 的frame
        let textLabelX = realValue(value: 0);
        let textLabelY = realValue(value: 0);
        let textLabelW = realValue(value: 160/2);
        let textLabelH = realValue(value: 32/2);
        textLabel.frame = CGRect(x: textLabelX, y: textLabelY, width: textLabelW, height: textLabelH);
        
        // 设置textDetailLabel 的frame
        let textDetailLabelX = textLabel.frame.maxX;
        let textDetailLabelY = textLabelY;
        let textDetailLabelW = width - textLabelW;
        let textDetailLabelH = textLabelH;
        textDetailLabel.frame = CGRect(x: textDetailLabelX, y: textDetailLabelY, width: textDetailLabelW, height: textDetailLabelH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
