//
//  JCMiddleController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/5.
//  Copyright © 2016年 zhangxu. All rights reserved.


import UIKit

class JCMiddleController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 普通cell标识
    private let middleCellIdentifier = "middleCellIdentifier";
    
    // 子菜单列表
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = .none;
        tableView.rowHeight = realValue(value: 163/2);
        return tableView;
    }();
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "middle_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 数据模型
    private lazy var middleModelArray: [JCMiddleModel] = [JCMiddleModel]();
    
    // 菜单名
    var menuName: String? {
        didSet {
            // 取出可选类型中的数据
            guard let menuName = menuName else {
                return;
            }
            
            if menuName == "菜单" {
                // 清空数组
                middleModelArray.removeAll();
                // 添加分类
                addSubMenuBtn();
                // 从服务器请求数据
                let url = "http://ac-otjqboap.clouddn.com/96fa891fd4dfd405feef.json";
                fetchSubMenuListFromServer(url: url);
                // 设置弹簧效果
                tableView.bounces = true;
            } else {
                
                // 清空数组
                middleModelArray.removeAll();
                // 订单
                let url = "http://ac-otjqboap.clouddn.com/a74e576a443b89c1c3e5.json";
                fetchSubMenuListFromServer(url: url);
                // 设置弹簧效果
                tableView.bounces = false;
            }
        }
    }
   
    
    // 闭包回调
    var sendMiddleCallBack: ((_ middleModel: JCMiddleModel) -> ())?;
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 添加右边线条
        view.addSubview(background);
        
        // 添加tableView
        background.addSubview(tableView);
        
        // 注册cell
        tableView.register(JCMiddleCell.self, forCellReuseIdentifier: middleCellIdentifier);
        
        // 第一次进来默认显示菜单的列表
        // 添加分类
        addSubMenuBtn();
        // 从服务器请求数据
        let url = "http://ac-otjqboap.clouddn.com/96fa891fd4dfd405feef.json";
        fetchSubMenuListFromServer(url: url);
        // 设置弹簧效果
        tableView.bounces = true;

    }
    
    // 添加分类
    @objc private func addSubMenuBtn() -> Void {
        
        let model = JCMiddleModel();
        model.name = "添加分类";
        model.img_url_normal = "middle_add_normal";
        model.img_url_selected = "middle_add_normal";
        middleModelArray.append(model);
    }
    
    // 请服务器请求数据
    private func fetchSubMenuListFromServer(url: String) -> Void {
        
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        mgr.request(.GET, urlString: url, parameters: nil, finished: { [weak self]
            (result, error) in
            
            if let error = error {
                print(error);
                return;
            }
            
            guard let result = result as? [String: Any] else {
                return;
            }
            
            let resultArray = result["results"] as? [[String: Any]];
            
            let _ = resultArray?.enumerated().map({
                (dict) in
                let model = JCMiddleModel.modelWidthDict(dict: dict.element);
                self?.middleModelArray.append(model);
            });
            
            // 设置默认选中状态
            let _ = self?.middleModelArray.enumerated().map({
                (element) in
                element.element.isSelected = (element.offset == 1) ? true : false;
            });
            
            // 刷新数据
            self?.tableView.reloadData();
        })
    }
    
    
    // MARK: - 返回行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return middleModelArray.count;
    }
    
    // MARK: - 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: middleCellIdentifier, for: indexPath) as?JCMiddleCell;
            let middleModel = middleModelArray[indexPath.row];
            cell?.middleModel = middleModel;
            return cell!;
    }
    
    // MARK: - 选中cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let middleModel = middleModelArray[indexPath.row];
        // 先将所有的isSelected设置为false
        if middleModel.name != "添加分类" {
            
            let _ = middleModelArray.enumerated().map({
                (model) in
                if indexPath.row > middleModelArray.count {return};
                model.element.isSelected = (model.offset == indexPath.row) ? true : false;
            });
            
            // 刷新表格
            tableView.reloadData();
        }
        
        if let sendMiddleCallBack = sendMiddleCallBack {
            sendMiddleCallBack(middleModel);
        }
        
    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置borderRightLine 的frame
        background.frame = view.bounds;
        
        // 设置tableView的frame
        let tableViewX = realValue(value: 1);
        let tableViewY = realValue(value: 74/2);
        let tableViewW = width - realValue(value: 2);
        let tableViewH = height - tableViewY;
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
