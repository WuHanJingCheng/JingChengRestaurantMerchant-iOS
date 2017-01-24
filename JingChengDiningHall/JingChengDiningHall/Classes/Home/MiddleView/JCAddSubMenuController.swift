//
//  JCAddSubMenuController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/7.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


enum ImageType {
    case normal
    case selected
}


class JCAddSubMenuController: UIViewController {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "addSubMenu_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    //  详细内容
    lazy var addSubMenuDetailView: JCAddSubMenuDetailView = JCAddSubMenuDetailView();
    
    private lazy var model: JCMiddleModel = JCMiddleModel();
    
    // 取消按钮回调
    var cancelBtnCallBack: (() -> ())?;
    // 确定按钮的点击回调
    var submitBtnCallBack: ((_ model: JCMiddleModel) -> ())?;
    
    deinit {
        print("JCAddSubMenuController 被释放了");
        // 移除通知
        NotificationCenter.default.removeObserver(self);
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景
        view.addSubview(background);
        
        // 添加详情
        background.addSubview(addSubMenuDetailView);
        
        // 打开相册的回调
        addSubMenuDetailView.openAlbumCallBack = { [weak self]
            (imageType) in
            
            self?.model.imageType = imageType;
           
            let albumVc = AlbumController();
            albumVc.shotScreenType = "84x64";
            let nav = UINavigationController.init(rootViewController: albumVc);
            self?.present(nav, animated: true, completion: nil)
            
            albumVc.screenshotCallBack = { [weak self]
                (image, vc) in
                
                // 压缩图片
                let smallImage = compressImage(sourceImage: image, targetSize: CGSize(width: realValue(value: 84/2), height: realValue(value: 64/2)));
                // 将image转化为data
                let imageData = UIImageJPEGRepresentation(smallImage, 1);
                
                // 保存图片
                if self?.model.imageType == .normal {
                    self?.model.image_normal_data = imageData;
                } else {
                    self?.model.image_selected_data = imageData;
                }
                self?.addSubMenuDetailView.model = self?.model;
                
                // 返回
                vc.dismiss(animated: true, completion: nil);
            }
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
            // 判断交互
            let result = self?.addSubMenuDetailView.controlHintInfo();
            
            if result == true {
                
                if let model = self?.model, let MenuName = self?.addSubMenuDetailView.categoryNameTextField.text {
                    
                    model.MenuName = MenuName;
                    if let submitBtnCallBack = self?.submitBtnCallBack {
                        submitBtnCallBack(model);
                    }
                }
            }
        }
        
        
        // 添加通知，监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);

        // Do any additional setup after loading the view.
    }
    
    // 展示子菜单信息
    func showSubMenuInfo(model: JCMiddleModel) {
        
        addSubMenuDetailView.showSubMenuInfo(model: model);
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
        let addSubMenuDetailViewW = realValue(value: 800/2);
        let addSubMenuDetailViewH = realValue(value: 628/2);
        addSubMenuDetailView.bounds = CGRect(x: 0, y: 0, width: addSubMenuDetailViewW, height: addSubMenuDetailViewH);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
