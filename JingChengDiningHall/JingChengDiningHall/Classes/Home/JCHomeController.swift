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
    
    // 我的
    private lazy var mineView: JCMineView = {
        let mineView = JCMineView();
        mineView.isHidden = true;
        return mineView;
    }();
    
    // 添加分类
    private lazy var addSubMenuView: JCAddSubMenuView = {
        let addSubMenuView = JCAddSubMenuView();
        addSubMenuView.isHidden = true;
        return addSubMenuView;
    }();
    
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self);
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
        
        // 我的
        view.addSubview(mineView);
        
        // 添加分类
        view.addSubview(addSubMenuView);
        
        // 将左边的值，传给子菜单
        leftVc.sendLeftModelCallBack = { [weak self]
            (jsonFileName) in
            guard let weakSelf = self else {
                return;
            }
            
            if jsonFileName == "JCSubMenusData.json" {
                weakSelf.rightVc.menuView.isHidden = false;
                weakSelf.rightVc.orderView.isHidden = true;
                weakSelf.middleVc.jsonFileName = jsonFileName;
            } else if jsonFileName == "JCOrderListData.json" {
                weakSelf.rightVc.menuView.isHidden = true;
                weakSelf.rightVc.orderView.isHidden = false;
                weakSelf.middleVc.jsonFileName = jsonFileName;
            } else if jsonFileName == "我的" {
                weakSelf.mineView.isHidden = false;
                weakSelf.mineView.mineDetailView.deleteBtn.addTarget(self, action: #selector(weakSelf.deleteBtnClick(button:)), for: .touchUpInside);
                weakSelf.mineView.mineDetailView.quiteBtn.addTarget(self, action: #selector(weakSelf.quiteBtnClick(button:)), for: .touchUpInside);
            }
        }
        
        middleVc.sendMiddleCallBack = {
            [weak self] (middleModel) in
            
            guard let weakSelf = self else {
                return;
            }
            
            if middleModel.title == "添加分类" {
                weakSelf.addSubMenuView.isHidden = false;
                weakSelf.addSubMenuView.addSubMenuDetailView.cancelBtn.addTarget(self, action: #selector(weakSelf.cancelBtnClick(button:)), for: .touchUpInside);
            } else {
                weakSelf.rightVc.middleModel = middleModel;
            }
        }

        // 添加通知，监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
        

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 取消
    func cancelBtnClick(button: UIButton) -> Void {
        
        addSubMenuView.isHidden = true;
    }
    
    // MARK: - 点击屏幕其他地方，回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    // MARK: - 键盘弹出
    func keyboardWillShow(notification: Notification) -> Void {
        
        guard let userInfo = notification.userInfo else {
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue;
        
        // 动画
        UIView.animate(withDuration: duration) {
            
            // 取出键盘高度
            let keyboardF = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
            let keyboardH = keyboardF.size.height;
            self.addSubMenuView.addSubMenuDetailView.transform = CGAffineTransform(translationX: 0, y: -keyboardH/2);
            
        }
    }
    
    // MARK: - 键盘影藏
    func keyboardWillHide(notification: Notification) -> Void {
        
        guard let userInfo = notification.userInfo else {
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue;
        // 动画
        UIView.animate(withDuration: duration) {
            
            self.addSubMenuView.addSubMenuDetailView.transform = CGAffineTransform.identity;
        }
    }
    
    // MARK: - 点击删除，弹框消失
    func deleteBtnClick(button: UIButton) -> Void {
        
        mineView.isHidden = true;
    }
    
    // MARK: - 退出登录
    func quiteBtnClick(button: UIButton) -> Void {
        
        dismiss(animated: true, completion: nil);
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
        
        // 我的
        mineView.frame = view.bounds;
        
        // 设置添加分类的frame
        addSubMenuView.frame = view.bounds;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
