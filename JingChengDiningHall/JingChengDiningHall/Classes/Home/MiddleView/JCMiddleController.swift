//
//  JCMiddleController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/5.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMiddleController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let middleCellIdentifier = "middleCellIdentifier";
    
    // 子菜单列表
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = .none;
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
    
    // JSON文件名
    var jsonFileName: String? {
        didSet {
            // 取出可选类型中的值
            guard let jsonFileName = jsonFileName else {
                return;
            }
            parseJSONFile(jsonFileName: jsonFileName);
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
        
        // 默认显示菜单的子菜单列表
        parseJSONFile(jsonFileName: "JCSubMenusData.json");

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 加载数据
    func parseJSONFile(jsonFileName: String) -> Void {
        
        // 清空数组
        middleModelArray.removeAll();
        
        let url = Bundle.main.url(forResource: jsonFileName, withExtension: nil);
        let data = try!Data.init(contentsOf: url!);
        let array = try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as![[String: AnyObject]];
        
        for (index,dic) in array.enumerated() {
            
            let middleModel = JCMiddleModel();
            middleModel.title = dic["title"] as?String ?? "";
            middleModel.imageName = dic["imageName"] as?String ?? "";
            middleModel.height = dic["height"]?.floatValue ?? 0;
            middleModel.width = dic["width"]?.floatValue ?? 0;
            middleModel.jsonFileName = jsonFileName;
            // 设置肉类为默认选中状态
            if index == 1 {
                middleModel.isSelected = true;
            }
            middleModelArray.append(middleModel);
            
        }
        
        tableView.reloadData();
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let middleModel = middleModelArray[indexPath.row];
        return JCMiddleCell.heightForCell(model: middleModel);
        
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
        
        // 先将所有的isSelected设置为false
        for model in middleModelArray {
            model.isSelected = false;
        }
        
        // 防止数组越界
        if indexPath.row >= middleModelArray.count {
            return;
        }
        
        let middleModel = middleModelArray[indexPath.row];
        middleModel.isSelected = true;
        
        // 刷新表格
        tableView.reloadData();
        
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
