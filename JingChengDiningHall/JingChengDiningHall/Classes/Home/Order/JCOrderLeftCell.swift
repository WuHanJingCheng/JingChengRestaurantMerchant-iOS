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
    
    // 就餐图标
    private lazy var dinnerIcon: UIImageView = UIImageView();
    
    // 几人桌标识
    private lazy var numberLabel: JCOrderNumberView = JCOrderNumberView();
    
    // 桌号
    private lazy var tableIdLabel: UILabel = {
        let tableIdLabel = UILabel();
        tableIdLabel.textAlignment = .center;
        tableIdLabel.font = Font(size: 20/2);
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
            
            if orderModel.isSelected == false {
                background.image = UIImage.imageWithName(name: "order_tableId_normal");
                dinnerIcon.image = UIImage.imageWithName(name: "order_tableId_dinner_normal");
                numberLabel.background.image = UIImage.imageWithName(name: "order_LeftCell_number_border_normal");
            } else {
                background.image = UIImage.imageWithName(name: "order_tableId_selected");
                dinnerIcon.image = UIImage.imageWithName(name: "order_tableId_dinner_selected");
                numberLabel.background.image = UIImage.imageWithName(name: "order_LeftCell_number_border_selected");
            }
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加圆形背景
        contentView.addSubview(background);
        
        // 添加就餐图标
        background.addSubview(dinnerIcon);
        
        // 添加几人桌
        background.addSubview(numberLabel);
        
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
        
        // 设置dinnerIcon 的frame
        let dinnerIconCenterX = backgroundW/2;
        let dinnerIconCenterY = realValue(value: 50/2) + realValue(value: 59/2/2);
        let dinnerIconW = realValue(value: 76/2);
        let dinnerIconH = realValue(value: 59/2);
        dinnerIcon.center = CGPoint(x: dinnerIconCenterX, y: dinnerIconCenterY);
        dinnerIcon.bounds = CGRect(x: 0, y: 0, width: dinnerIconW, height: dinnerIconH);
        
        // 设置几人桌的frame
        let numberLabelCenterX = backgroundW/2;
        let numberLabelCenterY = dinnerIcon.frame.maxY + realValue(value: 15/2 + 30/2/2);
        let numberLabelW = realValue(value: 80/2);
        let numberLabelH = realValue(value: 30/2);
        numberLabel.center = CGPoint(x: numberLabelCenterX, y: numberLabelCenterY);
        numberLabel.bounds = CGRect(x: 0, y: 0, width: numberLabelW, height: numberLabelH);
        
        // 设置桌号的frame
        let tableIdLabelCenterX = backgroundW/2;
        let tableIdLabelCenterY = background.frame.maxY + realValue(value: 10/2 + 20/2/2);
        let tableIdLabelW = backgroundW;
        let tableIdLabelH = realValue(value: 20/2);
        tableIdLabel.center = CGPoint(x: tableIdLabelCenterX, y: tableIdLabelCenterY);
        tableIdLabel.bounds = CGRect(x: 0, y: 0, width: tableIdLabelW, height: tableIdLabelH);
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
