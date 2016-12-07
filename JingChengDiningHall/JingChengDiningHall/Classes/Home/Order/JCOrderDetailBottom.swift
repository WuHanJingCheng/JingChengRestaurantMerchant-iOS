//
//  JCOrderDetailBottom.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderDetailBottom: UIView {

    // 顶部分割线
    private lazy var topLine: UIImageView = {
        let topLine = UIImageView();
        topLine.image = UIImage.imageWithName(name: "orderDetail_line");
        return topLine;
    }();
    
    // 服务员
    private lazy var waiterLabel: UILabel = {
        let waiterLabel = UILabel();
        waiterLabel.text = "服务员： 张三";
        waiterLabel.font = Font(size: 24/2);
        waiterLabel.textAlignment = .left;
        waiterLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return waiterLabel;
    }();
    
    // 日期
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel();
        dateLabel.text = "2016-10-17  18：20";
        dateLabel.textAlignment = .right;
        dateLabel.font = Font(size: 24/2);
        dateLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return dateLabel;
    }();
    
    // 底部分割线
    private lazy var bottomLine: UIImageView = {
        let bottomLine = UIImageView();
        bottomLine.image = UIImage.imageWithName(name: "orderDetail_line");
        return bottomLine;
    }();
    
    // 合计
    private lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel();
        totalPriceLabel.text = "合计  ￥98.00";
        totalPriceLabel.textAlignment = .right;
        totalPriceLabel.font = Font(size: 52/2);
        totalPriceLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return totalPriceLabel;
    }();

    // 结账
    private lazy var paidBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "orderDetail_paidBtn"), for: .normal);
        button.setTitle("结账", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 48/2);
        return button;
    }();
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加topLine
        addSubview(topLine);
        
        // 添加waiterLabel
        addSubview(waiterLabel);
        
        // 添加dateLabel
        addSubview(dateLabel);
        
        // 添加bottomLine
        addSubview(bottomLine);
        
        // 添加totalPriceLabel
        addSubview(totalPriceLabel);
        
        // 添加paidBtn
        addSubview(paidBtn);
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置topLine 的frame
        let topLineCenterX = width/2;
        let topLineCenterY = realValue(value: 0.5);
        let topLineW = realValue(value: 519/2);
        let topLineH = realValue(value: 1);
        topLine.center = CGPoint(x: topLineCenterX, y: topLineCenterY);
        topLine.bounds = CGRect(x: 0, y: 0, width: topLineW, height: topLineH);
        
        // 设置waiterLabel 的frame
        let waiterLabelX = realValue(value: 30/2);
        let waiterLabelY = realValue(value: 20/2);
        let waiterLabelW = calculateWidth(title: waiterLabel.text!, fontSize: 24/2);
        let waiterLabelH = realValue(value: 24/2);
        waiterLabel.frame = CGRect(x: waiterLabelX, y: waiterLabelY, width: waiterLabelW, height: waiterLabelH);
        
        // 设置dateLabel 的frame
        let dateLabelY = waiterLabelY;
        let dateLabelW = calculateWidth(title: dateLabel.text!, fontSize: 24/2);
        let dateLabelX = width - realValue(value: 30/2) - dateLabelW;
        let dateLabelH = waiterLabelH;
        dateLabel.frame = CGRect(x: dateLabelX, y: dateLabelY, width: dateLabelW, height: dateLabelH);
        
        // 设置bottomLine 的frame
        let bottomLineCenterX = width/2;
        let bottomLineCenterY = dateLabel.frame.maxY + realValue(value: 20/2 + 0.5);
        let bottomLineW = topLineW;
        let bottomLineH = topLineH;
        bottomLine.center = CGPoint(x: bottomLineCenterX, y: bottomLineCenterY);
        bottomLine.bounds = CGRect(x: 0, y: 0, width: bottomLineW, height: bottomLineH);
        
        // 设置totalPriceLabel 的frame
        let totalPriceLabelX = realValue(value: 0);
        let totalPriceLabelY = bottomLine.frame.maxY + realValue(value: 40/2);
        let totalPriceLabelW = width - realValue(value: 30/2);
        let totalPriceLabelH = realValue(value: 52/2);
        totalPriceLabel.frame = CGRect(x: totalPriceLabelX, y: totalPriceLabelY, width: totalPriceLabelW, height: totalPriceLabelH);
        
        // 设置paidBtn 的frame
        let paidBtnCenterX = width/2;
        let paidBtnCenterY = totalPriceLabel.frame.maxY + realValue(value: 50/2 + 88/2/2);
        let paidBtnW = realValue(value: 478/2);
        let paidBtnH = realValue(value: 88/2);
        paidBtn.center = CGPoint(x: paidBtnCenterX, y: paidBtnCenterY);
        paidBtn.bounds = CGRect(x: 0, y: 0, width: paidBtnW, height: paidBtnH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
