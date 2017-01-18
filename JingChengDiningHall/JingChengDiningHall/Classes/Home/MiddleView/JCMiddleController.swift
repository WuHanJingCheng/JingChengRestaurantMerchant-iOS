//
//  JCMiddleController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/5.
//  Copyright © 2016年 zhangxu. All rights reserved.


import UIKit

class JCMiddleController: UIViewController {
    
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "middle_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 菜单
    private lazy var menuListView: JCMiddleMenuListView = {
        let menuListView = JCMiddleMenuListView();
        menuListView.isHidden = false;
        return menuListView;
    }();
    
    // 订单
    private lazy var orderListView: JCMiddleOrderListView = {
        let orderListView = JCMiddleOrderListView();
        orderListView.isHidden = true;
        return orderListView;
    }();
    
    // 子菜单回调
    var subMenuCallBack: ((_ model: JCMiddleModel) -> ())?;
    // 子订单菜单回调
    var orderCallBack: ((_ model: JCMiddleModel) -> ())?;
    // 添加分类按钮的回调
    var addBtnCallBack: ((_ menulist: [JCMiddleModel]) -> ())?;
    
    // 菜单名
    var menuName: String? {
        didSet {
            // 取出可选类型中的数据
            guard let menuName = menuName else {
                return;
            }
            
            if menuName == "菜单" {
                
                self.menuListView.isHidden = false;
                self.orderListView.isHidden = true;
            } else {
 
                self.menuListView.isHidden = true;
                self.orderListView.isHidden = false;
            }
        }
    }
    
    
    deinit {
        print("JCMiddleController 被释放了");
        // 移除通知
        NotificationCenter.default.removeObserver(self);
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加右边线条
        view.addSubview(background);
        
        // 添加菜单
        background.addSubview(menuListView);
        
        // 添加订单
        background.addSubview(orderListView);
        
        // menuListView 的子菜单回调
        menuListView.subMenuCallBack = { [weak self]
            (model) in
            
            if let subMenuCallBack = self?.subMenuCallBack {
                subMenuCallBack(model);
            }
        }
        
        // 添加分类按钮的点击回调
        menuListView.addBtnCallBack = { [weak self]
            (menulist) in
            if let addBtnCallBack = self?.addBtnCallBack {
                addBtnCallBack(menulist);
            }
        }
        
        // orderList的子菜单回调
        orderListView.orderCallBack = { [weak self]
            (model) in
            
            if let orderCallBack = self?.orderCallBack {
                orderCallBack(model);
            }
        }
     
    }
    
    //  菜品   删除子菜单
    func deleteSubMenu(model: JCMiddleModel) -> Void {
        
        menuListView.deleteSubMenu(model: model);
    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        // 设置菜单的frame
        menuListView.frame = background.bounds;
        
        // 设置订单的frame
        orderListView.frame = background.bounds;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
