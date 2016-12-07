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
    private lazy var icon: UIImageView = UIImageView();
    
    // 子菜单标题
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel();
        titleLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        titleLabel.font = Font(size: 24/2);
        titleLabel.textAlignment = .center;
        return titleLabel;
    }();
    
    private var imageH: CGFloat? = 0;
    private var imageW: CGFloat? = 0;
    
    var middleModel: JCMiddleModel? {
        didSet {
            guard let middleModel = middleModel else {
                return;
            }
            
            if let imageName = middleModel.imageName {
                if middleModel.isSelected == false {
                    let normalImageName = imageName + "_normal";
                    icon.image = UIImage.imageWithName(name: normalImageName);
                } else {
                    let seletedImageName = imageName + "_selected";
                    icon.image = UIImage.imageWithName(name: seletedImageName);
                }
                
            }
        
            if let title = middleModel.title {
                if middleModel.isSelected == false {
                    titleLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
                } else {
                    titleLabel.textColor = RGBWithHexColor(hexColor: 0xdc9b3e);
                }
                titleLabel.text = title;
            }
            
            if let imageWidth = middleModel.width {
                imageW = realValue(value: CGFloat(imageWidth));
            }
            
            if let imageHeight = middleModel.height {
                imageH = realValue(value: CGFloat(imageHeight));
            }

            setNeedsLayout();
            layoutIfNeeded();
        }
    }
    
  
    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 取消选中状态
        selectionStyle = .none;
        
        // 添加子菜单图标
        contentView.addSubview(icon);
        
        // 添加子菜单标题
        contentView.addSubview(titleLabel);
        
    }
    
    // MARK: - 返回cell高度
    class func heightForCell(model: JCMiddleModel) -> CGFloat {
        
        var cellHeight = realValue(value: 99/2);
        let imageHeight = CGFloat(model.height!)/2;
        cellHeight = cellHeight + realValue(value: imageHeight);
        return cellHeight;
        
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置icon 的frame
        let iconCenterX = width/2;
        let iconCenterY = realValue(value: 30/2 + imageH!/2/2);
        let iconW = imageW!/2;
        let iconH = imageH!/2;
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
