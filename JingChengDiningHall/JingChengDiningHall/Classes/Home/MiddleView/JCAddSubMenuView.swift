//
//  JCAddSubMenuView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/20.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCAddSubMenuView: UIView {

    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "home_addSubMenu_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    //  详细内容
    lazy var addSubMenuDetailView: JCAddSubMenuDetailView = JCAddSubMenuDetailView();
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加详情
        background.addSubview(addSubMenuDetailView);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置addSubMenuDetailView 的frame
        addSubMenuDetailView.center = center;
        let addSubMenuDetailViewW = realValue(value: 890/2);
        let addSubMenuDetailViewH = realValue(value: 684/2);
        addSubMenuDetailView.bounds = CGRect(x: 0, y: 0, width: addSubMenuDetailViewW, height: addSubMenuDetailViewH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
