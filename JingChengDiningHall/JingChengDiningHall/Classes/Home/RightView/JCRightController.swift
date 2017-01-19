//
//  JCRightController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/5.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCRightController: UIViewController {
    
    // 菜单
    lazy var menuView: JCMenuView = JCMenuView();
    
    // 订单
    lazy var orderView: JCOrderView = JCOrderView();


    // 添加菜的回调
    var addDishCallBack: ((_ model: JCMiddleModel) -> ())?;
    // 编辑回调
    var editBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 删除回调
    var deleteBtnCallBack: ((_ model: JCDishModel) -> ())?;
    
    
    deinit {
        print("JCRightController 被释放了");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加菜单
        view.addSubview(menuView);
        
        // 添加订单
        orderView.isHidden = true;
        view.addSubview(orderView);
        
        
        // 添加菜的回调
        menuView.addDishCallBack = { [weak self]
            (model) in
            
            if let addDishCallBack = self?.addDishCallBack {
                addDishCallBack(model);
            }
        }
        
        // 编辑回调
        menuView.editBtnCallBack = { [weak self]
            (model) in
            
            if let editBtnCallBack = self?.editBtnCallBack {
                editBtnCallBack(model);
            }
        }
        
        // 删除
        menuView.deleteBtnCallBack = { [weak self]
            (model) in
            
            if let deleteBtnCallBack = self?.deleteBtnCallBack {
                deleteBtnCallBack(model);
            }
        }
        
    }
    
    // 刷新菜品列表
    func updateDishList(model: JCMiddleModel) -> Void {
        
        menuView.updateDishList(model: model);
    }
    
    // 删除菜品，刷新
    func deleteDish(model: JCDishModel) -> Void {
        
        menuView.deleteDish(model: model);
    }
    
    
    // 添加菜品
    func addDish(model: JCDishModel) -> Void {
        
        menuView.addDish(model: model);
    }
    
    // 修改菜品
    func modifityDish(model: JCDishModel) -> Void {
        
        menuView.modifityDish(model: model);
    }
    
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        // 设置菜单的frame
        menuView.frame = view.bounds;
        
        // 设置订单的frame
        orderView.frame = view.bounds;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
