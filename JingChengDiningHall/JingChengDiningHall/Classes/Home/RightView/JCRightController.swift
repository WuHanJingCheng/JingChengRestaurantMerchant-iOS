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
    
    // 数据模型
    var middleModel: JCMiddleModel? {
        didSet {
            // 取出可选类型中的数据
            guard let middleModel = middleModel else {
                return;
            }
            
            if middleModel.jsonFileName == "JCSubMenusData.json" {
                
                // 隐藏订单页面
                orderView.isHidden = true;
                menuView.isHidden = false;
                
            } else if middleModel.jsonFileName == "JCOrderListData.json" {
                // 隐藏菜单页面
                menuView.isHidden = true;
                orderView.isHidden = false;
                
                if middleModel.title == "记录" {
                    orderView.orderLeftView.isHidden = true;
                    orderView.recordView.isHidden = false;
                } else {
                    orderView.orderLeftView.isHidden = false;
                    orderView.recordView.isHidden = true;
                }
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加菜单
        view.addSubview(menuView);
        
        // 添加订单
        orderView.isHidden = true;
        view.addSubview(orderView);
        
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
