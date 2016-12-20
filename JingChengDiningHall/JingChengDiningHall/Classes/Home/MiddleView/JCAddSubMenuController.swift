//
//  JCAddSubMenuController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/7.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCAddSubMenuController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "home_addSubMenu_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    //  详细内容
    lazy var addSubMenuDetailView: JCAddSubMenuDetailView = JCAddSubMenuDetailView();
    
    // 取消按钮回调
    var cancelBtnCallBack: (() -> ())?;
    // 确定按钮的点击回调
    var submitBtnCallBack: (() -> ())?;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景
        view.addSubview(background);
        
        // 添加详情
        background.addSubview(addSubMenuDetailView);
        
        // 打开相册的回调
        addSubMenuDetailView.openAlbumCallBack = { [weak self]
            _ in
            
            // 设置方向
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return;
            }
            // 设置为横屏
            appDelegate.oriation = .all;
            // 创建照片选择器
            let imagePicker = UIImagePickerController();
            imagePicker.delegate = self;
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true;
            self?.present(imagePicker, animated: true, completion: nil);
        }
        
        // 取消按钮回调
        addSubMenuDetailView.cancelBtnCallBack = { [weak self]
            _ in
            
            if let cancelBtnCallBack = self?.cancelBtnCallBack {
                cancelBtnCallBack();
            }
        }
        
        // 确定按钮的点击回调
        addSubMenuDetailView.submitBtnCallBack = { [weak self]
            _ in
            
            if let submitBtnCallBack = self?.submitBtnCallBack {
                submitBtnCallBack();
            }
        }
        
        
        // 添加通知，监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);

        // Do any additional setup after loading the view.
    }
    
    // 取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return;
        }
        appDelegate.oriation = .landscape;
        picker.dismiss(animated: false, completion: nil);
    }
    
    // 选中照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 获取代理对象
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return;
        }
        // 设置横屏
        appDelegate.oriation = .landscape;
        // 获取image中的数据
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return;
        };
        // 保存图片
        addSubMenuDetailView.icon.image = image;
        // 让控制器消失
        dismiss(animated: true, completion: nil);
    }
    
    // MARK: - 点击屏幕其他地方，回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    // MARK: - 键盘弹出
    @objc private func keyboardWillShow(notification: Notification) -> Void {
        
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
            self.addSubMenuDetailView.transform = CGAffineTransform(translationX: 0, y: -keyboardH/2);
            
        }
    }
    
    // MARK: - 键盘影藏
    @objc private func keyboardWillHide(notification: Notification) -> Void {
        
        guard let userInfo = notification.userInfo else {
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue;
        // 动画
        UIView.animate(withDuration: duration) {
            
            self.addSubMenuDetailView.transform = CGAffineTransform.identity;
        }
    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        let width = background.bounds.size.width;
        let height = background.bounds.size.height;
        
        // 设置addSubMenuDetailView 的frame
        addSubMenuDetailView.center = CGPoint(x: width/2, y: height/2);
        let addSubMenuDetailViewW = realValue(value: 890/2);
        let addSubMenuDetailViewH = realValue(value: 684/2);
        addSubMenuDetailView.bounds = CGRect(x: 0, y: 0, width: addSubMenuDetailViewW, height: addSubMenuDetailViewH);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
