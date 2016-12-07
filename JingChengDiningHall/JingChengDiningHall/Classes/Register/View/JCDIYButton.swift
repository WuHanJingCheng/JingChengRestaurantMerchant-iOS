//
//  JCDIYButton.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDIYButton: UIButton {
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setImage(UIImage.imageWithName(name: "register_backbtn"), for: .normal);
        setTitle("返回登录", for: .normal);
        setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        
    }

    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let imageX = realValue(value: 10/2);
        let imageY = realValue(value: 10/2);
        let imageW = realValue(value: 24/2);
        let imageH = realValue(value: 45/2);
        let rect = CGRect.init(x: imageX, y: imageY, width: imageW, height: imageH);
        return rect;
        
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let titleX = realValue(value: 54/2);
        let titleY = realValue(value: 33/2/2);
        let titleW = realValue(value: 32*5/2);
        let titleH = realValue(value: 32/2);
        let rect = CGRect.init(x: titleX, y: titleY, width: titleW, height: titleH);
        return rect;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
