//
//  JCAddSubMenuDetailView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/20.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCAddSubMenuDetailView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "home_addSubMenuDetail_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 添加分类
    private lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.text = "添加分类";
        label.textAlignment = .center;
        label.font = Font(size: 48/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 图片
    lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage.imageWithName(name: "home_addSubMenuDetail_icon");
        icon.isUserInteractionEnabled = true;
        return icon;
    }();
    
    // 分类名称
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        label.text = "分类名称";
        return label;
    }();
    
    // 分类名称输入框
    private lazy var categoryNameTextField: UITextField = {
        let textField = UITextField();
        textField.background = UIImage.imageWithName(name: "home_addSubMenu_categoryTextField");
        textField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        textField.textAlignment = .left;
        textField.font = Font(size: 32/2);
        textField.clearButtonMode = .whileEditing;
        textField.borderStyle = .none;
        return textField;
    }();
    
    // 取消
    lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("取消", for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.addTarget(self, action: #selector(cancleBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 确定
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("确定", for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.addTarget(self, action: #selector(submitBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 打开相册的回调
    var openAlbumCallBack: (() -> ())?;
    // 取消按钮回调
    var cancelBtnCallBack: (() -> ())?;
    // 确定按钮的回调
    var submitBtnCallBack: (() -> ())?;
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加分类标题
        background.addSubview(titleLabel);
        
        // 添加icon
        background.addSubview(icon);
        
        // 添加分类名称
        background.addSubview(categoryNameLabel);
        
        // 添加分类名称输入框
        background.addSubview(categoryNameTextField);
        
        // 添加取消按钮
        background.addSubview(cancelBtn);
        
        // 添加确定按钮
        background.addSubview(submitBtn);
        
        // 添加轻拍手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction));
        icon.addGestureRecognizer(tap);
        
    }
    
    // 点击取消按钮，隐藏弹框
    @objc private func cancleBtnClick() {
        
        if let cancelBtnCallBack = cancelBtnCallBack {
            cancelBtnCallBack();
        }
    }
    
    // 监听确定按钮的点击
    @objc private func submitBtnClick() {
        
        if let submitBtnCallBack = submitBtnCallBack {
            submitBtnCallBack();
        }
    }
    
    // 点击图片，打开相册
    @objc private func tapAction() -> Void {
        
        if let openAlbumCallBack = openAlbumCallBack {
            openAlbumCallBack();
        }
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置background 的frame
        background.frame = bounds;
        
        // 设置titleLabel 的frame
        let titleLabelCenterX = width/2;
        let titleLabelCenterY = realValue(value: 40/2 + 48/2/2);
        let titleLabelW = width;
        let titleLabelH = realValue(value: 48/2);
        titleLabel.center = CGPoint(x: titleLabelCenterX, y: titleLabelCenterY);
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleLabelW, height: titleLabelH);
        
        // 设置icon的frame
        let iconCenterX = width/2;
        let iconCenterY = titleLabel.frame.maxY + realValue(value: 60/2 + 296/2/2);
        let iconW = realValue(value: 364/2);
        let iconH = realValue(value: 296/2);
        icon.center = CGPoint(x: iconCenterX, y: iconCenterY);
        icon.bounds = CGRect(x: 0, y: 0, width: iconW, height: iconH);
        
        // 设置categoryNameLabel 的frame
        let categoryNameLabelX = realValue(value: 60/2);
        let categoryNameLabelY = icon.frame.maxY + realValue(value: 60/2);
        let categoryNameLabelW = calculateWidth(title: "分类名称", fontSize: 32/2);
        let categoryNameLabelH = realValue(value: 32/2);
        categoryNameLabel.frame = CGRect(x: categoryNameLabelX, y: categoryNameLabelY, width: categoryNameLabelW, height: categoryNameLabelH);
        
        // 设置categoryNameTextField 的frame
        let categoryNameTextFieldX = categoryNameLabel.frame.maxX + realValue(value: 20/2);
        let categoryNameTextFieldY = categoryNameLabelY;
        let categoryNameTextFieldW = realValue(value: 500/2);
        let categoryNameTextFieldH = realValue(value: 32/2);
        categoryNameTextField.frame = CGRect(x: categoryNameTextFieldX, y: categoryNameTextFieldY, width: categoryNameTextFieldW, height: categoryNameTextFieldH);
        
        // 设置cancelBtn 的frame 
        let cancelBtnX = realValue(value: 288/2);
        let cancelBtnY = categoryNameLabel.frame.maxY + realValue(value: 60/2);
        let cancelBtnW = calculateWidth(title: "取消", fontSize: 36/2);
        let cancelBtnH = realValue(value: 36/2);
        cancelBtn.frame = CGRect(x: cancelBtnX, y: cancelBtnY, width: cancelBtnW, height: cancelBtnH);
        
        // 设置submitBtn 的frame
        let submitBtnW = calculateWidth(title: "确定", fontSize: 36/2);
        let submitBtnX = width - realValue(value: 288/2) - submitBtnW;
        let submitBtnY = cancelBtnY;
        let submitBtnH = cancelBtnH;
        submitBtn.frame = CGRect(x: submitBtnX, y: submitBtnY, width: submitBtnW, height: submitBtnH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
