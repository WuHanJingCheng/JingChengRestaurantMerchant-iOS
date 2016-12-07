//
//  JCOrderRecordCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderRecordCell: UICollectionViewCell {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "record_background_normal");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 订单号
    private lazy var orderNumberLabel: UILabel = {
        let orderNumberLabel = UILabel();
        orderNumberLabel.text = "订单号";
        orderNumberLabel.textAlignment = .left;
        orderNumberLabel.textColor = RGBWithHexColor(hexColor: 0xffffff);
        orderNumberLabel.font = Font(size: 32/2);
        return orderNumberLabel;
    }();
    
    // 桌子背景
    private lazy var tableBackground: UIImageView = {
        let tableBackground = UIImageView();
        tableBackground.image = UIImage.imageWithName(name: "record_tableBackground");
        return tableBackground;
    }();
    
    // 桌子几人桌
    private lazy var customersLabel: JCOrderNumberView = JCOrderNumberView();
    
    // 桌号
    private lazy var tableIdLabel: UILabel = {
        let tableIdLabel = UILabel();
        tableIdLabel.textAlignment = .center;
        tableIdLabel.font = Font(size: 24/2);
        tableIdLabel.text = "1号桌";
        tableIdLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return tableIdLabel;
    }();
    
    // 价格
    private lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.text = "￥298.00";
        label.textAlignment = .right;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 时间
    private lazy var timeLabel: UILabel = {
        let label = UILabel();
        label.text = "13:00";
        label.font = Font(size: 24/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        return label;
    }();
    
    // 日期
    private lazy var dateLabel: UILabel = {
        let label = UILabel();
        label.text = "2016-10-12";
        label.font = Font(size: 24/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .right;
        return label;
    }();
    
    var orderRecordModel: JCOrderRecordModel? {
        didSet {
            // 取出可选类型中的数据
            guard let orderRecordModel = orderRecordModel else {
                return;
            }
            
            if orderRecordModel.isSelected == false {
                background.image = UIImage.imageWithName(name: "record_background_normal");
            } else {
                background.image = UIImage.imageWithName(name: "record_background_selected");
            }
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加orderNumberLabel 
        background.addSubview(orderNumberLabel);
        
        // 添加tableBackground 
        background.addSubview(tableBackground);
        
        // 添加customersLabel 
        customersLabel.background.image = UIImage.imageWithName(name: "record_table_customers");
        tableBackground.addSubview(customersLabel);
        
        // 添加价格
        background.addSubview(priceLabel);
        
        // 添加时间
        background.addSubview(timeLabel);
        
        // 添加日期
        background.addSubview(dateLabel);
        
        // 添加tableIdLabel
        background.addSubview(tableIdLabel);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置background 的frame
        background.frame = bounds;
        
        // 设置orderNumberLabel 的frame
        let orderNumberLabelX = realValue(value: 15/2);
        let orderNumberLabelY = realValue(value: 12/2);
        let orderNumberLabelW = width;
        let orderNumberLabelH = realValue(value: 32/2);
        orderNumberLabel.frame = CGRect(x: orderNumberLabelX, y: orderNumberLabelY, width: orderNumberLabelW, height: orderNumberLabelH);
        
        // 设置tableBackground 的frame 
        let tableBackgroundX = realValue(value: 15/2);
        let tableBackgroundY = realValue(value: 76/2);
        let tableBackgroundW = realValue(value: 128/2);
        let tableBackgroundH = tableBackgroundW;
        tableBackground.frame = CGRect(x: tableBackgroundX, y: tableBackgroundY, width: tableBackgroundW, height: tableBackgroundH);
        
        // 设置customersLabel 的frame
        let customersLabelCenterX = tableBackgroundW/2;
        let customersLabelCenterY = realValue(value: 85/2 + 30/2/2);
        let customersLabelW = realValue(value: 60/2);
        let customersLabelH = realValue(value: 26/2);
        customersLabel.center = CGPoint(x: customersLabelCenterX, y: customersLabelCenterY);
        customersLabel.bounds = CGRect(x: 0, y: 0, width: customersLabelW, height: customersLabelH);
        
        // 设置价格的frame
        let priceLabelX = tableBackground.frame.maxX;
        let priceLabelY = realValue(value: 106/2);
        let priceLabelW = width - priceLabelX - realValue(value: 15/2);
        let priceLabelH = realValue(value: 32/2);
        priceLabel.frame = CGRect(x: priceLabelX, y: priceLabelY, width: priceLabelW, height: priceLabelH);
        
        // 设置时间的frame
        let timeLabelX = priceLabelX;
        let timeLabelY = priceLabel.frame.maxY + realValue(value: 40/2);
        let timeLabelW = priceLabelW;
        let timeLabelH = realValue(value: 24/2);
        timeLabel.frame = CGRect(x: timeLabelX, y: timeLabelY, width: timeLabelW, height: timeLabelH);
        
        // 设置日期的frame
        let dateLabelX = priceLabelX;
        let dateLabelY = realValue(value: 216/2);
        let dateLabelW = priceLabelW;
        let dateLabelH = realValue(value: 24/2);
        dateLabel.frame = CGRect(x: dateLabelX, y: dateLabelY, width: dateLabelW, height: dateLabelH);
        
        // 设置tableIdLabel 
        let tableIdLabelCenterX = tableBackground.center.x;
        let tableIdLabelCenterY = tableBackground.frame.maxY + realValue(value: 10/2 + 24/2/2);
        let tableIdLabelW = tableBackgroundW;
        let tableIdLabelH = realValue(value: 24/2);
        tableIdLabel.center = CGPoint(x: tableIdLabelCenterX, y: tableIdLabelCenterY);
        tableIdLabel.bounds = CGRect(x: 0, y: 0, width: tableIdLabelW, height: tableIdLabelH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
