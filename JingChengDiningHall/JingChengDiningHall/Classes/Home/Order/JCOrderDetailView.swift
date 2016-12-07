//
//  JCOrderDetailView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderDetailView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // cell标识 
    private let orderDetailCellIdentifer = "orderDetailCellIdentifer";
    
    // 数组
    private lazy var orderDetailModelArray: [JCOrderDetailModel] = [JCOrderDetailModel]();

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.isUserInteractionEnabled = true;
        background.image = UIImage.imageWithName(name: "orderDetail_background");
        return background;
    }();
    
    // 头部
    private lazy var orderDetailHeader: JCOrderDetailHeader = JCOrderDetailHeader();
    
    // 菜品列表
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = UIColor.clear;
        tableView.separatorStyle = .none;
        tableView.rowHeight = realValue(value: 82/2);
        return tableView;
    }();
    
    // 底部
    private lazy var orderDetailBottom: JCOrderDetailBottom = JCOrderDetailBottom();
    
    // MARK: - 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加头部
        background.addSubview(orderDetailHeader);
        
        // 添加菜品列表
        background.addSubview(tableView);
        
        // 添加底部
        background.addSubview(orderDetailBottom);
        
        // 注册cell
        tableView.register(JCOrderDetailCell.self, forCellReuseIdentifier: orderDetailCellIdentifer);
        
        // 加载数据
        setData();
        
    }
    
    func setData() -> Void {
        
        for _ in 0..<10 {
            let model = JCOrderDetailModel();
            orderDetailModelArray.append(model);
        }
        
        // 刷新数据
        tableView.reloadData();
    }
    
    // MARK: - 返回行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    // MARK: - 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: orderDetailCellIdentifer, for: indexPath) as?JCOrderDetailCell;
        cell?.checkBox.tag = indexPath.row + 1000;
        cell?.checkBox.addTarget(self, action: #selector(checkBoxClick(button:)), for: .touchUpInside);
        let orderDetailModel = orderDetailModelArray[indexPath.row];
        if orderDetailModel.isSelected == true {
            cell?.checkBox.isSelected = true;
        } else {
            cell?.checkBox.isSelected = false;
        }
        return cell!;
    }
    
    // MARK: - 操作复选框的状态
    func checkBoxClick(button: UIButton) -> Void {
        
        button.isSelected = !button.isSelected;
        
        let orderDetailModel = orderDetailModelArray[button.tag - 1000];
        orderDetailModel.isSelected = button.isSelected;
        
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置头部的frame
        let orderDetailHeaderX = realValue(value: 0);
        let orderDetailHeaderY = realValue(value: 0);
        let orderDetailHeaderW = width;
        let orderDetailHeaderH = realValue(value: 414/2);
        orderDetailHeader.frame = CGRect(x: orderDetailHeaderX, y: orderDetailHeaderY, width: orderDetailHeaderW, height: orderDetailHeaderH);
        
        // 设置tableview 的frame
        let tableViewX = realValue(value: 0);
        let tableViewY = orderDetailHeader.frame.maxY;
        let tableViewW = orderDetailHeaderW;
        let tableViewH = realValue(value: 620/2);
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
        
        // 设置orderDetailBottom 的frame
        let orderDetailBottomX = realValue(value: 0);
        let orderDetailBottomY = tableView.frame.maxY;
        let orderDetailBottomW = orderDetailHeaderW;
        let orderDetailBottomH = height - orderDetailBottomY;
        orderDetailBottom.frame = CGRect(x: orderDetailBottomX, y: orderDetailBottomY, width: orderDetailBottomW, height: orderDetailBottomH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
