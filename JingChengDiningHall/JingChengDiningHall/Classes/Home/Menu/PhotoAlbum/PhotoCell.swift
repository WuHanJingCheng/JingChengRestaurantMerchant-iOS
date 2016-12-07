//
//  PhotoCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    lazy var icon: UIImageView = {
        let icon = UIImageView();
        return icon;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加icon
        contentView.addSubview(icon);
    }
    
    // 设置icon的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置icon的frame
        icon.frame = bounds;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
