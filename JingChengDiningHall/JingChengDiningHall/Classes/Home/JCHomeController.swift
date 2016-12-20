//
//  JCHomeController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCHomeController: UIViewController {
    
    // 顶部
    private lazy var topView: JCTopView = JCTopView();
    
    // 左侧
    private lazy var leftVc: JCLeftController = JCLeftController();
    
    // 中间子菜单
    private lazy var middleVc: JCMiddleController = JCMiddleController();
    
    // 右边视图
    private lazy var rightVc: JCRightController = JCRightController();
    
    
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    // 显示状态栏为lightContent
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        // 添加顶部视图
        view.addSubview(topView);
        
        // 添加左侧视图
        view.addSubview(leftVc.view);
        addChildViewController(leftVc);
        
        // 添加中间子菜单
        view.addSubview(middleVc.view);
        addChildViewController(middleVc);
 
        // 添加右边视图
        view.addSubview(rightVc.view);
        addChildViewController(rightVc);
  
        
        // 将左边的值，传给子菜单
        leftVc.sendLeftModelCallBack = { [weak self]
            (menuName) in
           
            switch menuName {
            case "我的":
                // 我的
                let mineView = JCMineView();
                mineView.frame = (self?.view.bounds)!;
                self?.view.addSubview(mineView);
                // 添加动画
                ZXAnimation.startAnimation(targetView: mineView);
                
                
                // 消失的回调
                mineView.deleteBtnCallBack = { [unowned mineView]
                    _ in
                    // 添加消失动画
                    ZXAnimation.stopAnimation(targetView: mineView);
                }
                
                // 退出的回调
                mineView.quiteBtnCallBack = { [weak self]
                    _ in
                    // 让控制器消失
                    self?.dismiss(animated: true, completion: nil);
                }
                
            case "菜单":
                // 菜单
                self?.rightVc.menuView.isHidden = false;
                self?.rightVc.orderView.isHidden = true;
                self?.middleVc.menuName = menuName;
                
            default:
                // 订单
                self?.rightVc.menuView.isHidden = true;
                self?.rightVc.orderView.isHidden = false;
                self?.middleVc.menuName = menuName;
                self?.rightVc.orderView.recordView.isHidden = true;
                self?.rightVc.orderView.orderLeftView.isHidden = false;
                // 发送通知
                NotificationCenter.default.post(name: ChangePaidBtnStatusNotification, object: nil, userInfo: ["ChangePaidBtnStatusNotification": "结账"]);
            }
        }
        
        middleVc.sendMiddleCallBack = {
            [weak self] (middleModel) in
            
            if middleModel.name == "添加分类" {
                // 添加弹框
                let addSubMenuVc = JCAddSubMenuController();
                addSubMenuVc.view.frame = (self?.view.bounds)!;
                self?.view.addSubview(addSubMenuVc.view);
                self?.addChildViewController(addSubMenuVc);
                ZXAnimation.startAnimation(targetView: addSubMenuVc.view);
                
                
                // 点击取消按钮隐藏
                addSubMenuVc.cancelBtnCallBack = { [unowned addSubMenuVc]
                    _ in
                    // 移除弹窗
                    ZXAnimation.stopAnimation(targetView: addSubMenuVc.view);
                }
                // 点击确定按钮，保存修改信息
                addSubMenuVc.submitBtnCallBack = {
                    _ in
                    // 保存修改信息
                }
            } else if middleModel.name == "记录" {
                
                // 隐藏订单卓号界面
                self?.rightVc.orderView.orderLeftView.isHidden = true;
                // 显示订单记录页面
                self?.rightVc.orderView.recordView.isHidden = false;
                
                // 隐藏空闲和停用页面
                self?.rightVc.orderView.forbidView.isHidden = true;
                // 显示订单详情页面
                self?.rightVc.orderView.orderDetailView.isHidden = false;
                
                // 发送通知
                NotificationCenter.default.post(name: ChangePaidBtnStatusNotification, object: nil, userInfo: ["ChangePaidBtnStatusNotification": "已结账"]);
            
            } else {
                self?.rightVc.middleModel = middleModel;
                // 显示订单卓号界面
                self?.rightVc.orderView.orderLeftView.isHidden = false;
                // 隐藏订单记录页面
                self?.rightVc.orderView.recordView.isHidden = true;
            
                
                let _ = self?.rightVc.orderView.orderLeftView.orderModelArray.enumerated().map({
                    (element) in
                    
                    if element.element.isSelected == true {
                        if element.element.tag == 0 {
                            // 隐藏空闲和停用页面
                            self?.rightVc.orderView.forbidView.isHidden = true;
                            // 显示订单详情页面
                            self?.rightVc.orderView.orderDetailView.isHidden = false;
                        } else {
                            
                            // 隐藏空闲和停用页面
                            self?.rightVc.orderView.forbidView.isHidden = false;
                            // 显示订单详情页面
                            self?.rightVc.orderView.orderDetailView.isHidden = true;
                        }
                    }
                });
                
                // 发送通知
                NotificationCenter.default.post(name: ChangePaidBtnStatusNotification, object: nil, userInfo: ["ChangePaidBtnStatusNotification": "结账"]);

            }
        }
        
        
        // 添加菜的回调
        rightVc.addDishCallBack = { [weak self]
            _ in
            let dishDetail = JCDishDetailController();
            dishDetail.view.frame = (self?.view.bounds)!;
            self?.view.addSubview(dishDetail.view);
            self?.addChildViewController(dishDetail);
            ZXAnimation.startAnimation(targetView: dishDetail.view);
            
            // 取消按钮的回调
            dishDetail.cancelCallBack = { [unowned dishDetail]
                _ in
                ZXAnimation.stopAnimation(targetView: dishDetail.view);
            }
            
            // 确定按钮的回调
            dishDetail.submitCallBack = {
                _ in
                print("保存成功");
            }
        }
        
        // 编辑回调
        rightVc.editBtnCallBack = { [weak self]
            _ in
            
            let dishDetail = JCDishDetailController();
            dishDetail.view.frame = (self?.view.bounds)!;
            self?.view.addSubview(dishDetail.view);
            self?.addChildViewController(dishDetail);
            ZXAnimation.startAnimation(targetView: dishDetail.view);
            
            // 取消按钮的回调
            dishDetail.cancelCallBack = { [unowned dishDetail]
                _ in
                ZXAnimation.stopAnimation(targetView: dishDetail.view);
            }
            
            // 确认按钮的回调
            dishDetail.submitCallBack = {
                _ in
                print("保存成功");
            }
        }
 
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置顶部
        let topViewX = CGFloat(0);
        let topViewY = CGFloat(40/2);
        let topViewW = width;
        let topViewH = CGFloat(88/2);
        topView.frame = CGRect(x: topViewX, y: topViewY, width: topViewW, height: topViewH);
        
        // 设置左侧视图
        let leftVcX = realValue(value: 0);
        let leftVcY = topView.frame.maxY;
        let leftVcW = realValue(value: 192/2);
        let leftVcH = height - leftVcY;
        leftVc.view.frame = CGRect(x: leftVcX, y: leftVcY, width: leftVcW, height: leftVcH);
        
        // 设置中间视图的frame
        let middleVcX = leftVc.view.frame.maxX;
        let middleVcY = leftVcY;
        let middleVcW = leftVcW;
        let middleVcH = leftVcH;
        middleVc.view.frame = CGRect(x: middleVcX, y: middleVcY, width: middleVcW, height: middleVcH);
        
        // 设置右侧视图的frame
        let rightVcX = middleVc.view.frame.maxX;
        let rightVcY = leftVcY;
        let rightVcW = width - middleVcX;
        let rightVcH = leftVcH;
        rightVc.view.frame = CGRect(x: rightVcX, y: rightVcY, width: rightVcW, height: rightVcH);
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
