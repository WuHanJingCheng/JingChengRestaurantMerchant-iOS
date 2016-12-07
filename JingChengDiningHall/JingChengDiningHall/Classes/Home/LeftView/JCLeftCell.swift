//
//  JCLeftCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCLeftCell: UITableViewCell {

    
    // 图标
    private lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.layer.cornerRadius = realValue(value: 116/2/2);
        return icon;
    }();
    
    // 名字
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel();
        nameLabel.textColor = RGBWithHexColor(hexColor: 0xffffff);
        nameLabel.font = Font(size: 32/2);
        nameLabel.textAlignment = .center;
        return nameLabel;
    }();
    
    // 选中状态标识
    lazy var deltaImage: UIImageView = {
        let deltaImage = UIImageView();
        deltaImage.image = UIImage.imageWithName(name: "leftCell_delta");
        deltaImage.backgroundColor = UIColor.clear;
        deltaImage.isHidden = true;
        return deltaImage;
    }();
    
    // 数据模型
    var leftModel: JCLeftModel? {
        didSet {
            guard let leftModel = leftModel else {
                return;
            }
            
            if let imageName = leftModel.imageName {
                icon.image = UIImage.imageWithName(name: imageName);
            }
            
            if let title = leftModel.title {
                nameLabel.text = title;
            }
        }
    }
    
    
    // MARK: - 初始化方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
   
        // 将cell颜色设置为透明色
        backgroundColor = UIColor.clear;
        
        // 取消选中状态
        selectionStyle = .none;
        
        // 添加icon
        contentView.addSubview(icon);
        
        // 添加名字
        contentView.addSubview(nameLabel);
        
        // 添加选中状态标识
        contentView.addSubview(deltaImage);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置icon 的frame
        let iconCenterX = width/2;
        let iconCenterY = realValue(value: 50/2 + 116/2/2);
        let iconW = realValue(value: 116/2);
        let iconH = iconW;
        icon.center = CGPoint(x: iconCenterX, y: iconCenterY);
        icon.bounds = CGRect(x: 0, y: 0, width: iconW, height: iconH);
        
        // 设置nameLabel 的frame
        let nameLabelCenterX = iconCenterX;
        let nameLabelCenterY = icon.frame.maxY + realValue(value: 20/2) + realValue(value: 32/2);
        let nameLabelW = iconW;
        let nameLabelH = realValue(value: 32/2);
        nameLabel.center = CGPoint(x: nameLabelCenterX, y: nameLabelCenterY);
        nameLabel.bounds = CGRect(x: 0, y: 0, width: nameLabelW, height: nameLabelH);
        
        // 设置选中状态标识的frame
        let deltaImageX = width - realValue(value: 18/2);
        let deltaImageY = iconCenterY - realValue(value: 32/2/2);
        let deltaImageW = realValue(value: 18/2);
        let deltaImageH = realValue(value: 32/2);
        deltaImage.frame = CGRect(x: deltaImageX, y: deltaImageY, width: deltaImageW, height: deltaImageH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
