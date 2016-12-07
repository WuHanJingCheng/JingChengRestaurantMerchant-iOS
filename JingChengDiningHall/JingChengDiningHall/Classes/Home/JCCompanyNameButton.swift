//
//  JCCompanyNameButton.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/19.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCCompanyNameButton: UIView {
    
    // 背景
    lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "mineDetail_company_background");
        return background;
    }();
    
    // 公司名称
    private lazy var textLabel: UITextField = {
        let textField = UITextField();
        textField.text = "公司名称";
        textField.font = Font(size: 36/2);
        textField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        textField.textAlignment = .left;
        textField.clearButtonMode = .whileEditing;
        return textField;
    }();

    override init(frame: CGRect) {
        super.init(frame: frame);
        // 添加背景
        addSubview(background);
        
        // 添加公司名称
        addSubview(textLabel);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        let width = bounds.size.width;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置公司名称的frame 
        let textLabelX = realValue(value: 60/2);
        let textLabelY = (height - realValue(value: 36/2))/2;
        let textLabelW = width - textLabelX - realValue(value: 20);
        let textLabelH = realValue(value: 36/2);
        textLabel.frame = CGRect(x: textLabelX, y: textLabelY, width: textLabelW, height: textLabelH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
