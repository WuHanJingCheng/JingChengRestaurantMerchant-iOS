//
//  JCOrderLeftCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderLeftCell: UICollectionViewCell {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.isUserInteractionEnabled = true;
        background.backgroundColor = UIColor.clear;
        return background;
    }();
    
    
    // 桌号
    private lazy var tableIdLabel: UILabel = {
        let tableIdLabel = UILabel();
        tableIdLabel.textAlignment = .center;
        tableIdLabel.font = Font(size: 32/2);
        tableIdLabel.text = "1号桌";
        tableIdLabel.textColor = RGBWithHexColor(hexColor: 0x4c4c4c);
        return tableIdLabel;
    }();
    
    var orderModel: JCOrderModel? {
        didSet {
            // 取出可选类型中的数据
            guard let orderModel = orderModel else {
                return;
            }
            
            switch orderModel.tag {
                // 就餐状态
            case 0:
                
                // 选中状态
                if orderModel.isSelected == true {
                    background.image = UIImage.imageWithName(name: "orderLeftCell_dinner_selected");
                }
                // 未选中状态
                else {
                    background.image = UIImage.imageWithName(name: "orderLeftCell_dinner_normal");
                }
                
                // 空闲状态
            case 1:
                
                // 选中状态
                if orderModel.isSelected == true {
                    background.image = UIImage.imageWithName(name: "orderLeftCell_free_selected");
                }
                // 未选中状态
                else {
                    background.image = UIImage.imageWithName(name: "orderLeftCell_free_normal");
                }
                // 停用状态
            default:
                // 停用选中状态
                if orderModel.isSelected == true {
                    background.image = UIImage.imageWithName(name: "orderLeftCell_forbid_selected");
                }
                // 停用未选中状态
                else {
                    background.image = UIImage.imageWithName(name: "orderLeftCell_forbid_normal");
                }
            }
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加圆形背景
        contentView.addSubview(background);
        
        // 添加桌号
        contentView.addSubview(tableIdLabel);
        
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置background的frame
        let backgroundX = realValue(value: 0);
        let backgroundY = realValue(value: 0);
        let backgroundW = width;
        let backgroundH = backgroundW;
        background.frame = CGRect(x: backgroundX, y: backgroundY, width: backgroundW, height: backgroundH);
        
        
        // 设置桌号的frame
        let tableIdLabelCenterX = backgroundW/2;
        let tableIdLabelCenterY = background.frame.maxY + realValue(value: 20/2 + 20/2/2);
        let tableIdLabelW = backgroundW;
        let tableIdLabelH = realValue(value: 20/2);
        tableIdLabel.center = CGPoint(x: tableIdLabelCenterX, y: tableIdLabelCenterY);
        tableIdLabel.bounds = CGRect(x: 0, y: 0, width: tableIdLabelW, height: tableIdLabelH);
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
