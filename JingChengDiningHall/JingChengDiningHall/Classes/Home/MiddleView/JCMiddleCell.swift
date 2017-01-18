//
//  JCMiddleCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMiddleCell: UITableViewCell {
    
    // 子菜单图标
    lazy var icon: UIImageView = UIImageView();
    
    // 子菜单标题
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel();
        titleLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        titleLabel.font = Font(size: 24/2);
        titleLabel.textAlignment = .center;
        return titleLabel;
    }();
    
    var middleModel: JCMiddleModel? {
        didSet {
            guard let middleModel = middleModel else {
                return;
            }
            
            if middleModel.isSelected == false {
                if let PictureUrl = middleModel.PictureUrl {
                    if PictureUrl.hasPrefix("http") {
                        icon.zx_setImageWithURL(PictureUrl);
                    } else {
                        icon.image = UIImage.imageWithName(name: PictureUrl);
                    }
                    
                }
                
            } else {
                
                if let PictureUrlSelected = middleModel.PictureUrlSelected {
                    if PictureUrlSelected.hasPrefix("http") {
                        icon.zx_setImageWithURL(PictureUrlSelected);
                    } else {
                        icon.image = UIImage.imageWithName(name: PictureUrlSelected);
                    }
                }
            }
        
        
            if let MenuName = middleModel.MenuName {
                if middleModel.isSelected == false {
                    titleLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
                } else {
                    if MenuName == "添加分类" {
                        titleLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
                    } else {
                        titleLabel.textColor = RGBWithHexColor(hexColor: 0xdc9b3e);
                    }
                }
                titleLabel.text = MenuName;
            }
        }
    }
    
  
    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 取消选中状态
        selectionStyle = .none;
        
        // 添加子菜单图标
        contentView.addSubview(icon);
        icon.clipsToBounds = true;
        
        // 添加子菜单标题
        contentView.addSubview(titleLabel);
        
    }
    
      
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        let imageH = realValue(value: 64/2);
        let imageW = realValue(value: 84/2);
        
        // 设置icon 的frame
        let iconCenterX = width/2;
        let iconCenterY = realValue(value: 30/2 + imageH/2);
        let iconW = imageW;
        let iconH = imageH;
        icon.center = CGPoint(x: iconCenterX, y: iconCenterY);
        icon.bounds = CGRect(x: 0, y: 0, width: iconW, height: iconH);
        
        // 设置titleLabel 的frame
        let titleLabelCenterX = iconCenterX;
        let titleLabelCenterY = icon.frame.maxY + realValue(value: 15/2 + 24/2/2);
        let titleLabelW = width;
        let titleLabelH = realValue(value: 24/2);
        titleLabel.center = CGPoint(x: titleLabelCenterX, y: titleLabelCenterY);
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleLabelW, height: titleLabelH);
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
