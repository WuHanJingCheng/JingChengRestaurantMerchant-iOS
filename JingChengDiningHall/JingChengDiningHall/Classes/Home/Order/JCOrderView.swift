//
//  JCOrderView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderView: UIView {
    
    // 订单详情
    private lazy var orderDetailView: JCOrderDetailView = JCOrderDetailView();
    
    // 桌号列表页面
    lazy var orderLeftView: JCOrderLeftView = JCOrderLeftView();
    
    // 订单记录
    lazy var recordView: JCOrderRecordView = JCOrderRecordView();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加桌号列表页面
        addSubview(orderLeftView);
        
        // 添加订单详情
        addSubview(orderDetailView);
        
        // 添加订单记录
        recordView.isHidden = true;
        addSubview(recordView);
 
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        
        // 设置桌号列表的frame
        let orderLeftViewX = realValue(value: 20/2);
        let orderLeftViewY = realValue(value: 10/2);
        let orderLeftViewW = realValue(value: 1068/2);
        let orderLeftViewH = realValue(value: 1398/2);
        orderLeftView.frame = CGRect(x: orderLeftViewX, y: orderLeftViewY, width: orderLeftViewW, height: orderLeftViewH);
        
        // 设置orderDetailView 的frame
        let orderDetailViewX = orderLeftView.frame.maxX;
        let orderDetailViewY = realValue(value: 0);
        let orderDetailViewW = realValue(value: 556/2);
        let orderDetailViewH = height;
        orderDetailView.frame = CGRect(x: orderDetailViewX, y: orderDetailViewY, width: orderDetailViewW, height: orderDetailViewH);
        
        // 设置recordView 的frame
        recordView.frame = CGRect(x: orderLeftViewX, y: orderLeftViewY, width: orderLeftViewW, height: orderLeftViewH);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
