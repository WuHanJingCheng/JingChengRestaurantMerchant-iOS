//
//  JCSearchBar.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCSearchBar: UIView {

    // 输入框
    private lazy var searchBar: UITextField = {
        let searchBar = UITextField();
        searchBar.placeholder = "菜名";
        searchBar.font = Font(size: 32/2);
        searchBar.clearButtonMode = .whileEditing;
        searchBar.textAlignment = .center;
        searchBar.background = UIImage.imageWithName(name: "top_searchBar");
        searchBar.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return searchBar;
    }();
    
    // 搜索按钮
    private lazy var searchBtn: UIButton = {
        let searchBtn = UIButton(type: .custom);
        searchBtn.setBackgroundImage(UIImage.imageWithName(name: "top_searchBtn"), for: .normal);
        return searchBtn;
    }();
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加输入框
        addSubview(searchBar);
        
        // 添加搜索按钮
        addSubview(searchBtn);
        
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
      
        // 设置searchBar 的frame
        let searchBarX = CGFloat(0);
        let searchBarY = CGFloat(0);
        let searchBarW = CGFloat(265/2);
        let searchBarH = CGFloat(60/2);
        searchBar.frame = CGRect(x: searchBarX, y: searchBarY, width: searchBarW, height: searchBarH);
        
        // 设置searchBtn 的frame
        let searchBtnX = searchBar.frame.maxX - CGFloat(1);
        let searchBtnY = CGFloat(0);
        let searchBtnW = CGFloat(72/2);
        let searchBtnH = CGFloat(60/2);
        searchBtn.frame = CGRect(x: searchBtnX, y: searchBtnY, width: searchBtnW, height: searchBtnH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
