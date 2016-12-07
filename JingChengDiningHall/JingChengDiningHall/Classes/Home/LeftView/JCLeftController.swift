//
//  JCLeftController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/5.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCLeftController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var leftCellIdentifier = "leftCellIdentifier";
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "left_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 菜单列表
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = realValue(value: 268/2);
        tableView.backgroundColor = UIColor.clear;
        tableView.separatorStyle = .none;
        return tableView;
    }();
    
    // 数组
    private lazy var leftModelArray: [JCLeftModel] = [JCLeftModel]();
    
    // 闭包
    var sendLeftModelCallBack: ((_ jsonFileName: String) -> ())?;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景
        view.addSubview(background);
        
        // 添加tableView
        background.addSubview(tableView);
        
        // 注册cell
        tableView.register(JCLeftCell.self, forCellReuseIdentifier: leftCellIdentifier);
        
        // 设置数据模型
        setData();

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 设置数据
    func setData() -> Void {
        
        let imageNameArray = ["left_mine", "left_menu", "left_order"];
        let titleArray = ["我的", "菜单", "订单"];
        
        for i in 0..<3 {
            
            let leftModel = JCLeftModel();
            leftModel.imageName = imageNameArray[i];
            leftModel.title = titleArray[i];
            leftModelArray.append(leftModel);
        }
        
        tableView.reloadData();
    }
    
    // MARK: - 返回行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftModelArray.count;
    }
    
    // MARK: - 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: leftCellIdentifier, for: indexPath) as?JCLeftCell;
        let leftModel = leftModelArray[indexPath.row];
        cell?.leftModel = leftModel;
        if indexPath.row == 1 {
            cell?.deltaImage.isHidden = false;
        }
        return cell!;
        
    }
    
    // MARK: - 选中cell切换子菜单列表
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as?JCLeftCell;
        
        var jsonFileName: String?;
        
        switch indexPath.row {
        case 0:
            cell?.deltaImage.isHidden = true;
            jsonFileName = "我的";
        case 1:
            for tempCell in tableView.visibleCells {
                let tempCell = tempCell as?JCLeftCell;
                tempCell?.deltaImage.isHidden = true;
            }
            cell?.deltaImage.isHidden = false;
            jsonFileName = "JCSubMenusData.json";
        default:
            for tempCell in tableView.visibleCells {
                let tempCell = tempCell as?JCLeftCell;
                tempCell?.deltaImage.isHidden = true;
            }
            cell?.deltaImage.isHidden = false;
            jsonFileName = "JCOrderListData.json";
        }
        
        if let sendLeftModelCallBack = sendLeftModelCallBack, let jsonFileName = jsonFileName {
            sendLeftModelCallBack(jsonFileName);
        }
    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        // 设置tableView 的frame
        let tableViewX = realValue(value: 0);
        let tableViewY = realValue(value: 20/2);
        let tableViewW = width;
        let tableViewH = height - tableViewY;
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
