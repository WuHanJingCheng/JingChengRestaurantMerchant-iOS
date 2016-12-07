//
//  JCDeleteDishView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/11/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDeleteDishView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "homeEdit_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 白色背景
    private lazy var whitebackground: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "homeEdit_delete_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    
    // 取消按钮
    private lazy var cancellBtn: UIButton = {
        let button = UIButton(type: .system);
        button.backgroundColor = UIColor.clear;
        button.addTarget(self, action: #selector(cancellBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 确定按钮
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system);
        button.backgroundColor = UIColor.clear;
        button.addTarget(self, action: #selector(submitBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 取消回调
    var cancelCallBack: (() -> ())?;
    
    // 确定回调
    var submitCallBack: (() -> ())?;
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加白色背景
        background.addSubview(whitebackground);
        
        // 添加取消按钮
        whitebackground.addSubview(cancellBtn);
        
        // 添加确定按钮
        whitebackground.addSubview(submitBtn);
    }
    
    // MARK: - 监听取消点击
    func cancellBtnClick(button: UIButton) -> Void {
        
        if let cancelCallBack = cancelCallBack {
            cancelCallBack();
        }
    }
    
    // MARK: - 监听确定点击
    func submitBtnClick(button: UIButton) -> Void {
        
        if let submitCallBack = submitCallBack {
            submitCallBack();
        }
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置白色背景的frame
        let whitebackgroundCenterX = width/2;
        let whitebackgroundCenterY = height/2;
        let whitebackgroundW = realValue(value: 552/2);
        let whitebackgroundH = realValue(value: 246/2);
        whitebackground.center = CGPoint(x: whitebackgroundCenterX, y: whitebackgroundCenterY);
        whitebackground.bounds = CGRect(x: 0, y: 0, width: whitebackgroundW, height: whitebackgroundH);
        
        // 设置取消按钮的frame
        let cancellBtnX = realValue(value: 0);
        let cancellBtnY = realValue(value: 156/2);
        let cancellBtnW = whitebackgroundW/2;
        let cancellBtnH = whitebackgroundH - cancellBtnY;
        cancellBtn.frame = CGRect(x: cancellBtnX, y: cancellBtnY, width: cancellBtnW, height: cancellBtnH);
        
        // 设置确定按钮的frame
        let submitBtnX = cancellBtn.frame.maxX;
        let submitBtnY = cancellBtn.frame.minY;
        let submitBtnW = cancellBtnW;
        let submitBtnH = cancellBtnH;
        submitBtn.frame = CGRect(x: submitBtnX, y: submitBtnY, width: submitBtnW, height: submitBtnH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
