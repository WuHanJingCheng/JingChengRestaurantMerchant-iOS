//
//  JCAddSubMenuBtn.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/28.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCAddSubMenuBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setImage(UIImage.imageWithName(name: "middle_add_normal"), for: .normal);
        
        titleLabel?.font = Font(size: 24/2);
        titleLabel?.textAlignment = .center;
        setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        setTitle("添加分类", for: .normal);
        
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        guard let image = self.image(for: .normal) else {
            return .zero;
        }
        
        let width = self.bounds.size.width;
        
        let imageW = image.size.width;
        let imageH = image.size.height;
        let imageX = (width - imageW)/2;
        let imageY = realValue(value: 30/2);
        let imageRect = CGRect(x: imageX, y: imageY, width: imageW, height: imageH);
        return imageRect;
    }
    
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        guard let image = self.image(for: .normal) else {
            return .zero;
        }
      
        let imageH = image.size.height;
        
        let width = self.bounds.size.width;
        
        let titleW = width;
        let titleH = realValue(value: 24/2);
        let titleX = (width - titleW)/2;
        let titleY = realValue(value: 30/2) + imageH + realValue(value: 15/2);
        let titleRect = CGRect(x: titleX, y: titleY, width: titleW, height: titleH);
        return titleRect;
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
