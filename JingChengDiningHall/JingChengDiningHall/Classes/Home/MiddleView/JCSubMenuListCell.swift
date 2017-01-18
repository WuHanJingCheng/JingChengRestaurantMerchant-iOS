//
//  JCSubMenuListCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/3.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCSubMenuListCell: UICollectionViewCell {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "submenulist_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 图标
    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        return icon;
    }();
    
    // 名字
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel();
        nameLabel.font = Font(size: 36/2);
        nameLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        nameLabel.textAlignment = .center;
        return nameLabel;
    }();
    
    // 删除按钮
    private lazy var deleteBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "submenulist_deletebtn"), for: .normal);
        button.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 删除回调
    var deleteCallBack: ((_ model: JCMiddleModel) -> ())?;
    
    
    var model: JCMiddleModel? {
        didSet {
            // 获取可选类型中的数据
            guard let model = model else {
                return;
            }
            
            // 图片
            if let PictureUrl = model.PictureUrl {
                icon.zx_setImageWithURL(PictureUrl);
            }
            
            // 名字
            if let MenuName = model.MenuName {
                nameLabel.text = MenuName;
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        // 添加背景
        contentView.addSubview(background);
        
        // 添加图标
        background.addSubview(icon);
        
        // 添加名字
        background.addSubview(nameLabel);
        
        // 添加删除按钮
        background.addSubview(deleteBtn);
        
    }
    
    // 监听删除按钮的点击
    @objc private func deleteBtnClick() {
        
        if let deleteCallBack = deleteCallBack, let model = self.model {
            deleteCallBack(model);
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置图标的frame
        let iconW = realValue(value: 84/2);
        let iconH = realValue(value: 64/2);
        let iconX = (width - iconW)/2;
        let iconY = (height - iconH)/2;
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
        
        // 设置名字的frame
        let nameLabelW = width;
        let nameLabelH = realValue(value: 36/2);
        let nameLabelX = (width - nameLabelW)/2;
        let nameLabelY = height - realValue(value: 30/2) - nameLabelH;
            nameLabel.frame = CGRect(x: nameLabelX, y: nameLabelY, width: nameLabelW, height: nameLabelH);
        
        // 设置删除按钮的frame
        let deleteBtnW = realValue(value: 32/2);
        let deleteBtnH = deleteBtnW;
        let deleteBtnX = width - realValue(value: 20/2) - deleteBtnW;
        let deleteBtnY = realValue(value: 20/2);
        deleteBtn.frame = CGRect(x: deleteBtnX, y: deleteBtnY, width: deleteBtnW, height: deleteBtnH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
