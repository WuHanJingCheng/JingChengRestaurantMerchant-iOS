//
//  JCStatusButton.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.


import UIKit

class JCStatusView: UIView {
    
    var icon: UIImageView!;// 图标
    var title: UILabel!;// 标题
    var iconW: CGFloat = 0;
    var iconH: CGFloat = 0;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 添加图标
        icon = UIImageView();
        addSubview(icon);
        
        // 添加标题
        title = UILabel();
        title.textAlignment = .left;
        title.font = Font(size: 32/2);
        title.textColor = RGBWithHexColor(hexColor: 0x4c4c4c);
        addSubview(title);
    }
    
    func calculateStatusWidth(text: String) -> CGFloat {
        
        return realValue(value: 20/2) + calculateWidth(title: text, fontSize: 32/2) + iconW;
    }
    

    override func layoutSubviews() {
        super.layoutSubviews();
   
        let height = bounds.size.height;
        
        guard let text = title.text else {
            return;
        }
    
        // 设置icon的frame
        let iconX = realValue(value: 0);
        let iconY = (height - iconH)/2;
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
        
        // 设置title的frame
        let titleX = icon.frame.maxX + realValue(value: 20/2);
        let titleY = (height - realValue(value: 32/2))/2;
        let titleW = calculateWidth(title: text, fontSize: 32/2);
        let titleH = realValue(value: 32/2);
        title.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH);
        
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
