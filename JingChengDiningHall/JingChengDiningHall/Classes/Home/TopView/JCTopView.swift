//
//  JCTopView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCTopView: UIView {

    // logo
    private lazy var logo: UIImageView = {
        let logo = UIImageView();
        logo.image = UIImage.imageWithName(name: "top_logo");
        logo.isUserInteractionEnabled = true;
        return logo;
    }();
    
    // 标题
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel();
        titleLabel.text = "菜名";
        titleLabel.textAlignment = .center;
        titleLabel.font = Font(size: 40/2);
        titleLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return titleLabel;
    }();
    
    // 搜索框
    private lazy var searchBar: JCSearchBar = JCSearchBar();
    
    // 底部线条
    private lazy var bottomLine: UIImageView = {
        let bottomLine = UIImageView();
        bottomLine.image = UIImage.imageWithName(name: "top_bottomline");
        return bottomLine;
    }();
    
    // 搜索
    var searchCallBack: ((_ keyword: String) -> ())?;
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
   
        // 添加logo
        addSubview(logo);
        
        // 添加标题
        addSubview(titleLabel);
        
        // 添加搜索框
        addSubview(searchBar);
        searchBar.searchBtn.addTarget(self, action: #selector(searchBtnClick(button:)), for: .touchUpInside);
        
        // 添加底部线条
        addSubview(bottomLine);
 
    }
    
    func searchBtnClick(button: UIButton) -> Void {
        
        if let searchCallBack = searchCallBack {
            searchCallBack("");
        }
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置logo的frame
        let logoX = CGFloat(40/2);
        let logoY = CGFloat(4);
        let logoW = CGFloat(170/2);
        let logoH = CGFloat(72/2);
        logo.frame = CGRect(x: logoX, y: logoY, width: logoW, height: logoH);
        
        // 设置titleLabel 的frame
        let titleLabelCenterX = width/2;
        let titleLabelCenterY = height/2;
        let titleLabelW = CGFloat(200);
        let titleLabelH = CGFloat(48/2);
        titleLabel.center = CGPoint(x: titleLabelCenterX, y: titleLabelCenterY);
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleLabelW, height: titleLabelH);
        
        // 设置searchBar 的frame
        let searchBarX = width - CGFloat(431/2);
        let searchBarY = CGFloat(7);
        let searchBarW = CGFloat(431/2);
        let searchBarH = CGFloat(60/2);
        searchBar.frame = CGRect(x: searchBarX, y: searchBarY, width: searchBarW, height: searchBarH);
        
        // 设置底部线条的frame
        let bottomLineX = CGFloat(0);
        let bottomLineY = height - CGFloat(1);
        let bottomLineW = width;
        let bottomLineH = CGFloat(1);
        bottomLine.frame = CGRect(x: bottomLineX, y: bottomLineY, width: bottomLineW, height: bottomLineH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
