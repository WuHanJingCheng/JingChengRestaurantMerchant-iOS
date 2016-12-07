//
//  JCMenuAddCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/11/16.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMenuAddCell: UICollectionViewCell {
    
    
    // 背景按钮
    private lazy var backgroundBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "menu_addDish_background"), for: .normal);
        button.setImage(UIImage.imageWithName(name: "menu_addDish"), for: .normal);
        button.addTarget(self, action: #selector(backgroundBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 加号按钮的点击回调，调用相册
    var backgroundBtnCallBack: (() -> ())?;
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景按钮
        contentView.addSubview(backgroundBtn);
        
    }
    
    // 监听加号按钮的点击，添加菜品
    func backgroundBtnClick() {
        
        if let backgroundBtnCallBack = backgroundBtnCallBack {
            backgroundBtnCallBack();
        }
    }
    
    // MARK: - 设置背景按钮的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置 背景按钮的frame
        backgroundBtn.frame = bounds;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
