//
//  AlbumCell.swift
//  自定义UIImagePickerController
//
//  Created by zhangxu on 2016/12/5.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    // 左边图标
    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.image = UIImage.imageWithName(name: "album_icon");
        return icon;
    }();
    
    // 相册名
    lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.text = "相册";
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 照片张数
    lazy var countLabel: UILabel = {
        let label = UILabel();
        label.text = "0";
        label.font = Font(size: 32/2);
        label.textAlignment = .left;
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 右边图标
    private lazy var rightIcon: UIImageView = {
        let rightIcon = UIImageView();
        rightIcon.image = UIImage(named: "album_rightIcon");
        return rightIcon;
    }();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 添加icon
        contentView.addSubview(icon);
        
        // 添加titleLabel
        contentView.addSubview(titleLabel);
        
        // 添加countLabel
        contentView.addSubview(countLabel);
        
        // 添加右边图标
        contentView.addSubview(rightIcon);
    
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置icon 的frame
        let iconW = realValue(value: 142/2);
        let iconH = iconW;
        let iconX = realValue(value: 20/2);
        let iconY = (height - iconH)/2;
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
        
        
        // 设置titleLabel 的frame
        let titleLabelX = icon.frame.maxX + realValue(value: 30/2);
        let titleLabelY = realValue(value: 50/2);
        let titleLabelW = realValue(value: 300);
        let titleLabelH = realValue(value: 36/2);
        titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH);
        
        // 设置countLabel 的frame
        let countLabelX = titleLabelX;
        let countLabelY = titleLabel.frame.maxY + realValue(value: 20/2);
        let countLabelW = titleLabelW;
        let countLabelH = realValue(value: 32/2);
        countLabel.frame = CGRect(x: countLabelX, y: countLabelY, width: countLabelW, height: countLabelH);
        
        // 设置rightIcon 的frame
        let rightIconW = realValue(value: 15/2);
        let rightIconH = realValue(value: 25/2);
        let rightIconX = width - rightIconW - realValue(value: 20/2);
        let rightIconY = (height - rightIconH)/2;
        rightIcon.frame = CGRect(x: rightIconX, y: rightIconY, width: rightIconW, height: rightIconH);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
