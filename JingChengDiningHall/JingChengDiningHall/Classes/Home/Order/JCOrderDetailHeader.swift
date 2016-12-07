//
//  JCOrderDetailHeader.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderDetailHeader: UIView {

    // 订单详情label
    private lazy var orderDetailLabel: UILabel = {
        let label = UILabel();
        label.text = "订单详情";
        label.font = Font(size: 48/2);
        label.textAlignment = .center;
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 顶部分割线
    private lazy var topLine: UIImageView = {
        let topLine = UIImageView();
        topLine.image = UIImage.imageWithName(name: "orderDetail_line");
        return topLine;
    }();
    
    // 桌号
    private lazy var tableIdLabel: UILabel = {
        let label = UILabel();
        label.text = "桌号： 002号";
        label.textAlignment = .left;
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.font = Font(size: 40/2);
        return label;
    }();
    
    // 顾客人数
    private lazy var cusomersLabel: UILabel = {
        let label = UILabel();
        label.text = "顾客人数： 4人";
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 订单号
    private lazy var orderIdLabel: UILabel = {
        let orderIdLabel = UILabel();
        orderIdLabel.text = "订单号： dh12345";
        orderIdLabel.font = Font(size: 32/2);
        orderIdLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        orderIdLabel.textAlignment = .left;
        return orderIdLabel;
    }();
    
    // 中间的分割线
    private lazy var middleLine: UIImageView = {
        let middleLine = UIImageView();
        middleLine.image = UIImage.imageWithName(name: "orderDetail_line");
        return middleLine;
    }();
    
    // 商品
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel();
        label.text = "菜名";
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 数量
    private lazy var numberLabel: UILabel = {
        let label = UILabel();
        label.text = "数量";
        label.textAlignment = .right;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 价格
    private lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.text = "价格";
        label.textAlignment = .right;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 上桌
    private lazy var statusLabel: UILabel = {
        let label = UILabel();
        label.text = "上桌";
        label.textAlignment = .right;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 底部分割线
    private lazy var bottomLine: UIImageView = {
        let bottomLine = UIImageView();
        bottomLine.image = UIImage.imageWithName(name: "orderDetail_line");
        return bottomLine;
    }();
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加orderDetailLabel
        addSubview(orderDetailLabel);
        
        // 添加topLine
        addSubview(topLine);
        
        // 添加tableIdLabel
        addSubview(tableIdLabel);
        
        // 添加cusomersLabel
        addSubview(cusomersLabel);
        
        // 添加orderIdLabel
        addSubview(orderIdLabel);
        
        // 添加middleLine
        addSubview(middleLine);
        
        // 添加dishNameLabel
        addSubview(dishNameLabel);
        
        // 添加numberLabel
        addSubview(numberLabel);
        
        // 添加priceLabel
        addSubview(priceLabel);
        
        // 添加statusLabel
        addSubview(statusLabel);
        
        // 添加bottomLine
        addSubview(bottomLine);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置orderDetailLabel
        let orderDetailLabelX = realValue(value: 0);
        let orderDetailLabelY = realValue(value: 35/2);
        let orderDetailLabelW = width;
        let orderDetailLabelH = realValue(value: 48/2);
        orderDetailLabel.frame = CGRect(x: orderDetailLabelX, y: orderDetailLabelY, width: orderDetailLabelW, height: orderDetailLabelH);
        
        // 设置topLine的frame
        let topLineCenterX = width/2;
        let topLineCenterY = orderDetailLabel.frame.maxY + realValue(value: 20/2 + 0.5);
        let topLineW = realValue(value: 519/2);
        let topLineH = realValue(value: 1);
        topLine.center = CGPoint(x: topLineCenterX, y: topLineCenterY);
        topLine.bounds = CGRect(x: 0, y: 0, width: topLineW, height: topLineH);
        
        // 设置tableIdLabel的frame
        let tableIdLabelX = realValue(value: 30/2);
        let tableIdLabelY = topLine.frame.maxY + realValue(value: 28/2);
        let tableIdLabelW = width - tableIdLabelX * CGFloat(2);
        let tableIdLabelH = realValue(value: 40/2);
        tableIdLabel.frame = CGRect(x: tableIdLabelX, y: tableIdLabelY, width: tableIdLabelW, height: tableIdLabelH);
        
        // 设置cusomersLabel 的frame
        let cusomersLabelX = tableIdLabelX;
        let cusomersLabelY = tableIdLabel.frame.maxY + realValue(value: 28/2);
        let cusomersLabelW = tableIdLabelW;
        let cusomersLabelH = realValue(value: 32/2);
        cusomersLabel.frame = CGRect(x: cusomersLabelX, y: cusomersLabelY, width: cusomersLabelW, height: cusomersLabelH);
        
        // 设置orderIdLabel 的frame
        let orderIdLabelX = tableIdLabelX;
        let orderIdLabelY = cusomersLabel.frame.maxY + realValue(value: 28/2);
        let orderIdLabelW = tableIdLabelW;
        let orderIdLabelH = realValue(value: 32/2);
        orderIdLabel.frame = CGRect(x: orderIdLabelX, y: orderIdLabelY, width: orderIdLabelW, height: orderIdLabelH);
        
        // 设置middleLine 的frame
        let middleLineCenterX = width/2;
        let middleLineCenterY = orderIdLabel.frame.maxY + realValue(value: 28/2 + 0.5);
        let middleLineW = topLineW;
        let middleLineH = topLineH;
        middleLine.center = CGPoint(x: middleLineCenterX, y: middleLineCenterY);
        middleLine.bounds = CGRect(x: 0, y: 0, width: middleLineW, height: middleLineH);
        
        // 设置dishNameLabel 的frame
        let dishNameLabelX = realValue(value: 30/2);
        let dishNameLabelY = middleLine.frame.maxY + realValue(value: 28/2);
        let dishNameLabelW = calculateWidth(title: "菜名", fontSize: 32/2);
        let dishNameLabelH = realValue(value: 32/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置numberLabel 的frame
        let numberLabelX = dishNameLabel.frame.maxX + realValue(value: 146/2);
        let numberLabelY = dishNameLabelY;
        let numberLabelW = calculateWidth(title: "数量", fontSize: 32/2);
        let numberLabelH = dishNameLabelH;
        numberLabel.frame = CGRect(x: numberLabelX, y: numberLabelY, width: numberLabelW, height: numberLabelH);
        
        // 设置priceLabel 的frame
        let priceLabelX = numberLabel.frame.maxX + realValue(value: 52/2);
        let priceLabelY = dishNameLabelY;
        let priceLabelW = calculateWidth(title: "价格", fontSize: 32/2);
        let priceLabelH = dishNameLabelH;
        priceLabel.frame = CGRect(x: priceLabelX, y: priceLabelY, width: priceLabelW, height: priceLabelH);
        
        // 设置statusLabel 的frame
        let statusLabelX = priceLabel.frame.maxX + realValue(value: 48/2);
        let statusLabelY = dishNameLabelY;
        let statusLabelW = calculateWidth(title: "上桌", fontSize: 32/2);
        let statusLabelH = dishNameLabelH;
        statusLabel.frame = CGRect(x: statusLabelX, y: statusLabelY, width: statusLabelW, height: statusLabelH);
        
        // 设置bottomLine 的frame
        let bottomLineCenterX = width/2;
        let bottomLineCenterY = dishNameLabel.frame.maxY + realValue(value: 28/2 + 0.5);
        let bottomLineW = topLineW;
        let bottomLineH = topLineH;
        bottomLine.center = CGPoint(x: bottomLineCenterX, y: bottomLineCenterY);
        bottomLine.bounds = CGRect(x: 0, y: 0, width: bottomLineW, height: bottomLineH);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
