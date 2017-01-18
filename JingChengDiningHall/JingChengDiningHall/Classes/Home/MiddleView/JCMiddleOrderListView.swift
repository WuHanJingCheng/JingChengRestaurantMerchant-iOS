//
//  JCMiddleOrderListView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/29.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMiddleOrderListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // cell标识
    private let orderListCellIdentifier = "orderListCellIdentifier";

    // 子菜单列表
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = .none;
        tableView.bounces = false;
        tableView.backgroundColor = UIColor.clear;
        tableView.showsVerticalScrollIndicator = false;
        tableView.rowHeight = realValue(value: 163/2);
        return tableView;
    }();
    
    // 数组
    private lazy var orderList: [JCMiddleModel] = [JCMiddleModel]();

    // 闭包传递Model
    var orderCallBack: ((_ model: JCMiddleModel) -> ())?;
    
    
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加tableView
        addSubview(tableView);
        
        // 注册cell
        tableView.register(JCMiddleCell.self, forCellReuseIdentifier: orderListCellIdentifier);
        
        // 加载数据
        analysisLocalJsonData();
    }
    
    // 加载数据
    func analysisLocalJsonData() -> Void {
        
        guard let url = Bundle.main.url(forResource: "orderList", withExtension: "json") else {
            return;
        }
        let data = try! Data.init(contentsOf: url);
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
            return;
        }
        
        guard let dict = json as? [String: Any] else {
            return;
        }
        
        guard let results = dict["results"] as? [[String: Any]] else {
            return;
        }
        
        for subDict in results {
            
            let model = JCMiddleModel.modelWidthDict(dict: subDict);
            orderList.append(model);
        }
        
        // 刷新UI
        tableView.reloadData();
    }
    
    // 返回行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count;
    }
    
    // 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: orderListCellIdentifier, for: indexPath) as? JCMiddleCell;
        let model = orderList[indexPath.row];
        cell?.middleModel = model;
        return cell!;
    }
    
    // 选中cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 先将所有的isSelected设置为false
        let _ = orderList.enumerated().map({
            (model) in
            if indexPath.row > orderList.count {return};
            model.element.isSelected = (model.offset == indexPath.row) ? true : false;
        });
        
        // 刷新表格
        tableView.reloadData();

        // 子菜单回调
        let selectedModel = orderList[indexPath.row];
        if let orderCallBack = orderCallBack {
            orderCallBack(selectedModel);
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置tableView的frame
        let tableViewX = realValue(value: 1);
        let tableViewY = realValue(value: 74/2);
        let tableViewW = width - realValue(value: 2);
        let tableViewH = height - tableViewY;
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
