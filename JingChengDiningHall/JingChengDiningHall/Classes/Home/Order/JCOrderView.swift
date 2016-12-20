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
    lazy var orderDetailView: JCOrderDetailView = JCOrderDetailView();
    
    // 禁用
    lazy var forbidView: JCForbidView = JCForbidView();
    
    // 桌号列表页面
    lazy var orderLeftView: JCOrderLeftView = JCOrderLeftView();
    
    // 订单记录
    lazy var recordView: JCOrderRecordView = JCOrderRecordView();
    
 
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加桌号列表页面
        addSubview(orderLeftView);
        
        // 添加订单详情
        orderDetailView.isHidden = false;
        addSubview(orderDetailView);
        
        // 添加订单记录
        recordView.isHidden = true;
        addSubview(recordView);
        
        // 添加禁用视图
        forbidView.isHidden = true;
        addSubview(forbidView);
        
        // 切换订单详情和停用状态的回调
        orderLeftView.changeStatusCallBack = { [weak self]
            (model) in
            
            switch model.tag {
            case 0:
                // 就餐
                self?.orderDetailView.isHidden = false;
                self?.forbidView.isHidden = true;
                self?.forbidView.model = model;
            case 1:
                // 空闲
                self?.orderDetailView.isHidden = true;
                self?.forbidView.isHidden = false;
                self?.forbidView.model = model;
            default:
                // 停用
                self?.orderDetailView.isHidden = true;
                self?.forbidView.isHidden = false;
                self?.forbidView.model = model;
            }
        }
        
        
        // 禁用中空闲和禁用的开关回调
        forbidView.orderTableCallBack = { [weak self]
            (model) in
            
            // 更新桌子状态
            let _ = self?.orderLeftView.orderModelArray.enumerated().map({
                (element) in
                
                if model.tableNumber == element.element.tableNumber, model.tag == 1 {
                    element.element.tag = model.tag;
                    let indexPath = IndexPath(item: element.offset, section: 0);
                    let cell = self?.orderLeftView.collectionView.cellForItem(at: indexPath) as? JCOrderLeftCell;
                    cell?.orderModel = element.element;
                    return;
                }
                
                if model.tableNumber == element.element.tableNumber, model.tag == 2 {
                    element.element.tag = model.tag;
                    let indexPath = IndexPath(item: element.offset, section: 0);
                    let cell = self?.orderLeftView.collectionView.cellForItem(at: indexPath) as? JCOrderLeftCell;
                    cell?.orderModel = element.element;
                    return;
                }
            });
        }
        
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
        
        // 设置禁用的frame
        forbidView.frame = orderDetailView.frame;
        
        // 设置recordView 的frame
        recordView.frame = CGRect(x: orderLeftViewX, y: orderLeftViewY, width: orderLeftViewW, height: orderLeftViewH);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
