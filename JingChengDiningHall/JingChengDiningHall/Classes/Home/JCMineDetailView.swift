//
//  JCMineDetailView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/19.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCMineDetailView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "mineDetail_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 头像
    private lazy var photo: UIImageView = {
        let photo = UIImageView();
        photo.image = UIImage.imageWithName(name: "mineDetail_photo");
        return photo;
    }();
    
    // 用户名
    private lazy var usernameLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 48/2);
        label.text = "张三";
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 编辑按钮
    private lazy var editBtn: UIButton = {
        let editBtn = UIButton(type: .custom);
        editBtn.setImage(UIImage.imageWithName(name: "mineDetail_editBtn"), for: .normal);
        return editBtn;
    }();
    
    // 编辑文字
    private lazy var editLabel: UILabel = {
        let editLabel = UILabel();
        editLabel.text = "编辑";
        editLabel.font = Font(size: 24/2);
        editLabel.textAlignment = .left;
        editLabel.textColor = RGBWithHexColor(hexColor: 0x4c4c4c);
        return editLabel;
    }();
    
    // 删除按钮
    private lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: .custom);
        deleteBtn.setImage(UIImage.imageWithName(name: "mineDetail_deleteBtn"), for: .normal);
        deleteBtn.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside);
        return deleteBtn;
    }();
    
    // 公司名称
    private lazy var nameLabel: JCCompanyNameButton = JCCompanyNameButton();
    
    // 姓名
    private lazy var detailUserNameLabel: JCDIYLabel = {
        let label = JCDIYLabel();
        label.textLabel.text = "姓名";
        label.textDetailLabel.text = "张三";
        return label;
    }();
    
    // 电话
    private lazy var phoneNumberLabel: JCDIYLabel = {
        let label = JCDIYLabel();
        label.textLabel.text = "电话";
        label.textDetailLabel.text = "+86-13342675325";
        return label;
    }();
    
    // 职位
    private lazy var positionLabel: JCDIYLabel = {
        let label = JCDIYLabel();
        label.textLabel.text = "职位";
        label.textDetailLabel.text = "前台";
        return label;
    }();
    
    // 退出
    private lazy var quiteBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "mineDetail_quiteBtn"), for: .normal);
        button.titleLabel?.font = Font(size: 48/2);
        button.setTitle("退出登录", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.addTarget(self, action: #selector(quiteBtnClick), for: .touchUpInside);
        return button;
    }();
    
    
    // 删除的回调
    var deleteBtnCallBack: (() -> ())?;
    // 退出回调
    var quiteBtnCallBack: (() -> ())?;
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加background 
        addSubview(background);
        
        // 添加photo
        background.addSubview(photo);
        
        // 添加usernameLabel
        background.addSubview(usernameLabel);
        
        // 添加editBtn 
        addSubview(editBtn);
        
        // 添加editLabel
        addSubview(editLabel);
        
        // 添加deleteBtn
        addSubview(deleteBtn);
        
        // 添加nameLabel 
        addSubview(nameLabel);
        
        // 添加detailUserNameLabel
        addSubview(detailUserNameLabel);
        
        // 添加phoneNumberLabel
        addSubview(phoneNumberLabel);
        
        // 添加positionLabel
        addSubview(positionLabel);
        
        // 添加quiteBtn
        addSubview(quiteBtn);

    }
    
    // 监听退出的点击
    @objc private func quiteBtnClick() -> Void {
        
        if let quiteBtnCallBack = quiteBtnCallBack {
            quiteBtnCallBack();
        }
    }
    
    // 监听删除的点击
    @objc private func deleteBtnClick() -> Void {
        
        if let deleteBtnCallBack = deleteBtnCallBack {
            deleteBtnCallBack();
        }
    }
    

    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;

        
        // 设置background 的frame
        background.frame = bounds;
        
        // 设置photo 的frame
        let photoX = realValue(value: 60/2);
        let photoY = realValue(value: 80/2);
        let photoW = realValue(value: 160/2);
        let photoH = photoW;
        photo.frame = CGRect(x: photoX, y: photoY, width: photoW, height: photoH);
        
        // 设置usernameLabel 的frame
        let usernameLabelX = photo.frame.maxX + realValue(value: 20/2);
        let usernameLabelY = photo.center.y - realValue(value: 48/2/2);
        let usernameLabelW = realValue(value: 180/2);
        let usernameLabelH = realValue(value: 48/2);
        usernameLabel.frame = CGRect(x: usernameLabelX, y: usernameLabelY, width: usernameLabelW, height: usernameLabelH);
        
        // 设置editBtn 的frame
        let editBtnX = usernameLabel.frame.maxX;
        let editBtnY = usernameLabelY;
        let editBtnW = realValue(value: 40/2);
        let editBtnH = realValue(value: 44/2);
        editBtn.frame = CGRect(x: editBtnX, y: editBtnY, width: editBtnW, height: editBtnH);
        
        // 设置编辑的frame
        let editLabelX = editBtn.frame.maxX + realValue(value: 20/2);
        let editLabelY = editBtnY + (editBtnH - realValue(value: 24/2));
        let editLabelW = realValue(value: 50);
        let editLabelH = realValue(value: 24/2);
        editLabel.frame = CGRect(x: editLabelX, y: editLabelY, width: editLabelW, height: editLabelH);
        
        // 设置deleteBtn 的frame
        let deleteBtnX = width - realValue(value: 74/2);
        let deleteBtnY = realValue(value: 40/2);
        let deleteBtnW = realValue(value: 34/2);
        let deleteBtnH = deleteBtnW;
        deleteBtn.frame = CGRect(x: deleteBtnX, y: deleteBtnY, width: deleteBtnW, height: deleteBtnH);
        
        // 设置nameLabel 的frame
        let nameLabelX = realValue(value: 0);
        let nameLabelY = photo.frame.maxY + realValue(value: 80/2);
        let nameLabelW = width;
        let nameLabelH = realValue(value: 68/2);
        nameLabel.frame = CGRect(x: nameLabelX, y: nameLabelY, width: nameLabelW, height: nameLabelH);
        
        // 设置detailUserNameLabel 的frame
        let detailUserNameLabelX = realValue(value: 60/2);
        let detailUserNameLabelY = nameLabel.frame.maxY + realValue(value: 80/2);
        let detailUserNameLabelW = width - detailUserNameLabelX;
        let detailUserNameLabelH = realValue(value: 32/2);
        detailUserNameLabel.frame = CGRect(x: detailUserNameLabelX, y: detailUserNameLabelY, width: detailUserNameLabelW, height: detailUserNameLabelH);
        
        // 设置phoneNumberLabel 的frame
        let phoneNumberLabelX = detailUserNameLabelX;
        let phoneNumberLabelY = detailUserNameLabel.frame.maxY + realValue(value: 80/2);
        let phoneNumberLabelW = detailUserNameLabelW;
        let phoneNumberLabelH = detailUserNameLabelH;
        phoneNumberLabel.frame = CGRect(x: phoneNumberLabelX, y: phoneNumberLabelY, width: phoneNumberLabelW, height: phoneNumberLabelH);
        
        // 设置positionLabel 的frame
        let positionLabelX = detailUserNameLabelX;
        let positionLabelY = phoneNumberLabel.frame.maxY + realValue(value: 80/2);
        let positionLabelW = detailUserNameLabelW;
        let positionLabelH = detailUserNameLabelH;
        positionLabel.frame = CGRect(x: positionLabelX, y: positionLabelY, width: positionLabelW, height: positionLabelH);
        
        // 设置quiteBtn 的frame
        let quiteBtnX = realValue(value: 0);
        let quiteBtnY = positionLabel.frame.maxY + realValue(value: 82/2);
        let quiteBtnW = width;
        let quiteBtnH = realValue(value: 100/2);
        quiteBtn.frame = CGRect(x: quiteBtnX, y: quiteBtnY, width: quiteBtnW, height: quiteBtnH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
