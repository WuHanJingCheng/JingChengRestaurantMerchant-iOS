//
//  JCMineView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/19.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCMineView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "mine_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 我的详情
    lazy var mineDetailView: JCMineDetailView = JCMineDetailView();
    

    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加我的详情
        mineDetailView.backgroundColor = UIColor.clear;
        background.addSubview(mineDetailView);

    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置背景的frame 
        background.frame = bounds;
        
        // 设置我的详情的frame
        mineDetailView.center = CGPoint(x: width/2, y: height/2);
        let mineDetailViewW = realValue(value: 732/2);
        let mineDetailViewH = realValue(value: 900/2);
        mineDetailView.bounds = CGRect(x: 0, y: 0, width: mineDetailViewW, height: mineDetailViewH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
