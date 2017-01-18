//
//  JCSubMenuTopView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/3.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCSubMenuTopView: UIView {
    
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "submenulist_top_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 返回按钮
    private lazy var backBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "submenulist_backbtn"), for: .normal);
        button.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside);
        return button;
    }();
    
    
    // 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.text = "类别管理";
        label.font = Font(size: 40/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        return label;
    }();
    

    
    // 监听返回按钮的点击回调
    var backBtnCallBack: (() -> ())?;
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加返回按钮
        background.addSubview(backBtn);
        
        // 添加标题 
        background.addSubview(titleLabel);
    }
    
    // 监听返回按钮点击
    @objc private func backBtnClick() -> Void {
        
        if let backBtnCallBack = backBtnCallBack {
            backBtnCallBack();
        }
        
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置backBtn 的frame
        let backBtnW = realValue(value: 44/2);
        let backBtnH = realValue(value: 44/2);
        let backBtnX = realValue(value: 40/2);
        let backBtnY = (height - backBtnH)/2;
        backBtn.frame = CGRect(x: backBtnX, y: backBtnY, width: backBtnW, height: backBtnH);
        
        // 设置titleLabel 的frame
        let titleLabelW = realValue(value: 200);
        let titleLabelH = realValue(value: 40/2);
        let titleLabelX = (width - titleLabelW)/2;
        let titleLabelY = (height - titleLabelH)/2;
        titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
