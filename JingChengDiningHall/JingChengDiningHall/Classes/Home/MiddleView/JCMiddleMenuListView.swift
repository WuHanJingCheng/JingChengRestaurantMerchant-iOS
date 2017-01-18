//
//  JCMiddleMenuListView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/29.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMiddleMenuListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // cell标识
    private let menuListCellIdentifier = "menuListCellIdentifier";

    // 添加分类
    private lazy var addBtn: JCAddSubMenuBtn = {
        let addBtn = JCAddSubMenuBtn(type: .custom);
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside);
        return addBtn;
    }();
    
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
    private lazy var menuList: [JCMiddleModel] = [JCMiddleModel]();
    
    // 选中cell，选中分类的回调
    var subMenuCallBack: ((_ model: JCMiddleModel) -> ())?;
    // 点击添加分类按钮的回调
    var addBtnCallBack: ((_ menuList: [JCMiddleModel]) -> ())?;
    
    // 下载任务
    var task: URLSessionDataTask?;
    
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加addBtn
        addSubview(addBtn);
        
        // 添加tableView
        addSubview(tableView);
        
        // 注册cell
        tableView.register(JCMiddleCell.self, forCellReuseIdentifier: menuListCellIdentifier);
        
        // 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMenuList(notification:)), name: ReloadMenuListNotification, object: nil);
        
        // 请求分类列表数据
        fetchMenuListFromServer(url: submenulistUrl(restaurantId: restaurantId), successCallBack: {
            (resultArr) in
            
            // 清空数组
            self.menuList.removeAll();
            
            // 更新数组
            self.menuList += resultArr;
            
            // 刷新数据
            self.tableView.reloadData();
            
            // 数据加载成功,更新子菜单菜品列表，更新子菜单列表
            if let subMenuCallBack = self.subMenuCallBack, self.menuList.count > 0 {
                let model = self.menuList[0];
                subMenuCallBack(model);
            }
           
            
        }, failureCallBack: {
            (error) in
            
            print("请求分类列表数据失败", error.localizedDescription);
        })
    }
    
    // 请求分类列表数据
    func fetchMenuListFromServer(url: String, successCallBack: @escaping(_ menulist: [JCMiddleModel]) -> (), failureCallBack: @escaping(_ error: Error) -> ()) -> Void {
        print("--------------\(url)");
        // 清空数组
        self.menuList.removeAll();
        // 发送请求
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.requestSerializer.cachePolicy = .useProtocolCachePolicy;
        task = mgr.get(url, parameters: nil, progress: nil, success: { (dataTask, result) in
            
            if let result = result {
                
                guard let resultArr = result as? [[String: Any]] else {
                    return;
                };
                
                let _ = resultArr.enumerated().map({
                    (dict) in
                    
                    let model = JCMiddleModel.modelWidthDict(dict: dict.element);
                    model.isSelected = (dict.offset == 0) ? true : false;
                    self.menuList.append(model);
                });
                
                // 请求成功后的回调
                successCallBack(self.menuList);
                
            }
            
        }, failure: { (dataTask, error) in
            
            failureCallBack(error);
        })
    }
    
    // 监听通知
    @objc private func reloadMenuList(notification: Notification) -> Void {
        // 先清空数组
        menuList.removeAll();
        
        if let info = notification.userInfo {
            guard let array = info["ReloadMenuListNotification"] as? [JCMiddleModel] else {
                return;
            }
            
            menuList += array;
            
            // 刷新数据
            tableView.reloadData();
        }
    }
    
    // 删除子菜单
    func deleteSubMenu(model: JCMiddleModel) -> Void {
        
        let _ = menuList.enumerated().map({
            (element) in
            
            if model.MenuId == element.element.MenuId {
                menuList.remove(at: element.offset);
            }
        });
        
        // 更新UI
        tableView.reloadData();
    }
    
    // 监听添加分类按钮的点击
    @objc private func addBtnClick() -> Void {
        
        // 取消请求
        task?.cancel();
        
        if let addBtnCallBack = addBtnCallBack {
            addBtnCallBack(menuList);
        }
    }
    
    // MARK: - 返回行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count;
    }
    
    // MARK: - 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuListCellIdentifier, for: indexPath) as?JCMiddleCell;
        let middleModel = menuList[indexPath.row];
        cell?.middleModel = middleModel;
        return cell!;
    }
    
    // MARK: - 选中cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 先将所有的isSelected设置为false
        let _ = menuList.enumerated().map({
            (model) in
            if indexPath.row > menuList.count {return};
            model.element.isSelected = (model.offset == indexPath.row) ? true : false;
        });
        
        // 刷新表格
        tableView.reloadData();
        
        // 子菜单回调
        if indexPath.row < menuList.count {
            
            let selectedModel = menuList[indexPath.row];
            if let subMenuCallBack = subMenuCallBack {
                subMenuCallBack(selectedModel);
            }
        }
        
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
 
        // 设置addBtn 的frame
        let addBtnX = realValue(value: 1);
        let addBtnY = realValue(value: 74/2);
        let addBtnW = width - realValue(value: 2);
        let addBtnH = realValue(value: 163/2);
        addBtn.frame = CGRect(x: addBtnX, y: addBtnY, width: addBtnW, height: addBtnH);
        
        // 设置tableView的frame
        let tableViewX = addBtnX
        let tableViewY = addBtn.frame.maxY;
        let tableViewW = addBtnW;
        let tableViewH = height - tableViewY;
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
