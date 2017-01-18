//
//  JCSearchController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCSearchController: UIViewController {

//    private let searchCellIdentifier = "searchCellIdentifier";
//    
//    var keyword: String?;
//    
//    // 搜索框
//    private lazy var searchView: JCSearchView = JCSearchView();
//    
//    // 日期label
//    private lazy var dateLabel: UILabel = {
//        let label = UILabel();
//        label.text = "";
//        label.font = Font(size: 32/2);
//        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
//        label.textAlignment = .left;
//        return label;
//    }();
//    
//    // 起始日期
//    private lazy var fromDateTextField: UITextField = {
//        let textField = UITextField();
//        textField.placeholder = "请输入开始时间";
//        textField.font = Font(size: 32/2);
//        textField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
//        textField.textAlignment = .center;
//        textField.borderStyle = .roundedRect;
//        textField.clearButtonMode = .whileEditing;
//        return textField;
//    }();
//    
//    // 结束日期
//    private lazy var toDateTextField: UITextField = {
//        let textField = UITextField();
//        textField.placeholder = "请输入结束时间";
//        textField.font = Font(size: 32/2);
//        textField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
//        textField.textAlignment = .center;
//        textField.borderStyle = .roundedRect;
//        textField.clearButtonMode = .whileEditing;
//        return textField;
//    }();
//    
//    // tableView
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView.init(frame: .zero, style: .plain);
//        tableView.dataSource = self;
//        tableView.delegate = self;
//        tableView.rowHeight = realValue(value: 76/2);
//        return tableView;
//    }();
//    
//    
//    // 搜索结果
//    private lazy var searchModelArray: [JCSearchModel] = [JCSearchModel]();
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = RGBWithHexColor(hexColor: 0xfbfaf8);
//        
//        // 添加搜索框
//        view.addSubview(searchView);
//        
//        // 起始日期
//        view.addSubview(fromDateTextField);
//        
//        // 结束日期
//        view.addSubview(toDateTextField);
//        
//        // 添加tableView
//        view.addSubview(tableView);
//        
//        
//        // 注册cell
//        tableView.register(JCSearchCell.self, forCellReuseIdentifier: searchCellIdentifier);
//        
//        
//    }
//    
//    // 返回行
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchModelArray.count;
//    }
//    
//    // 返回cell
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellIdentifier, for: indexPath) as? JCSearchCell;
//        return cell!;
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//        
//    }
//    
//    // 设置子控件的frame
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews();
//        
//        
//    }
//    
//

}
