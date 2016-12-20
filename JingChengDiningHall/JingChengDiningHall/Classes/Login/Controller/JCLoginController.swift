//
//  JCLoginController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCLoginController: UIViewController {
    
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "login_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 白色背景
    private lazy var whiteBackground: UIImageView = {
        let whiteBackground = UIImageView();
        whiteBackground.image = UIImage.imageWithName(name: "login_whitebackground");
        whiteBackground.isUserInteractionEnabled = true;
        return whiteBackground;
    }();
    
    // logo
    private lazy var logo: UIImageView = {
        let logo = UIImageView();
        logo.image = UIImage.imageWithName(name: "login_logo_background");
        return logo;
    }();
    
    // 商户ID
    private lazy var merchantIdView: JCAccountView = JCAccountView();
    
    // 账户
    private lazy var accountView: JCAccountView = JCAccountView();
    
    // 密码
    private lazy var passwordView: JCPasswordView = JCPasswordView();
    
    // 登录按钮
    private lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom);
        loginBtn.setBackgroundImage(UIImage.imageWithName(name: "login_btn"), for: .normal);
        loginBtn.setTitle("登录", for: .normal);
        loginBtn.titleLabel?.font = Font(size: 36/2);
        loginBtn.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        loginBtn.addTarget(self, action: #selector(loginBtnClick(button:)), for: .touchUpInside);
        return loginBtn;
    }();
    
    // 忘记密码按钮
    private lazy var forgetpasswordBtn: UIButton = {
        let forgetpasswordBtn = UIButton(type: .custom);
        forgetpasswordBtn.setTitle("忘记密码？", for: .normal);
        forgetpasswordBtn.setTitleColor(RGBWithHexColor(hexColor: 0x999999), for: .normal);
        forgetpasswordBtn.titleLabel?.font = Font(size: 36/2);
        forgetpasswordBtn.addTarget(self, action: #selector(forgetpasswordBtnClick(button:)), for: .touchUpInside);
        return forgetpasswordBtn;
    }();
    
    // 密码错误提示
    private lazy var accountPromptLabel: UILabel = {
        let label = UILabel();
        label.text = "*你的账户或密码错误，请重新登录";
        label.textColor = RGBWithHexColor(hexColor: 0xf48383);
        label.font = Font(size: 28/2);
        label.textAlignment = .center;
        label.isHidden = true;
        return label;
    }();
    
    
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景
        view.addSubview(background);
        
        // 添加白色背景
        background.addSubview(whiteBackground);
        
        // 添加logo
        whiteBackground.addSubview(logo);
        
        // 添加商户ID
        whiteBackground.addSubview(merchantIdView);
        merchantIdView.accountLabel.text = "商户ID";
        merchantIdView.accountTextField.placeholder = "商户ID";
        
        // 添加账户
        whiteBackground.addSubview(accountView);
        
        // 添加密码
        whiteBackground.addSubview(passwordView);
        
        // 登录按钮
        whiteBackground.addSubview(loginBtn);
        
        // 添加忘记密码按钮
        whiteBackground.addSubview(forgetpasswordBtn);
        
        // 添加通知，监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
        

        // Do any additional setup after loading the view.
    }
    
  
    // MARK: - 点击屏幕其他地方，回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    // MARK: - 点击忘记密码按钮，进入忘记密码界面
    func forgetpasswordBtnClick(button: UIButton) -> Void {
        
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
            self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardH/2);
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
            
            self.view.transform = CGAffineTransform.identity;
        }
    }

    // MARK: - 点击登录按钮，进入主页
    func loginBtnClick(button: UIButton) -> Void {
        
        debugPrint("点击了登录按钮");
    
        
        let homeVc = JCHomeController();
        homeVc.modalTransitionStyle = .crossDissolve;
        present(homeVc, animated: true, completion: nil);
  
    }
    
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置背景的frame
        background.frame = view.bounds;
  
        // 设置白色背景的frame
        let whiteBackgroundCenterX = width/2;
        let whiteBackgroundCenterY = height/2;
        let whiteBackgroundW = realValue(value: 814/2);
        let whiteBackgroundH = realValue(value: 760/2);
        whiteBackground.center = CGPoint(x: whiteBackgroundCenterX, y: whiteBackgroundCenterY);
        whiteBackground.bounds = CGRect(x: 0, y: 0, width: whiteBackgroundW, height: whiteBackgroundH);
        
        // 设置logo 的frame
        let logoW = realValue(value: 389/2);
        let logoH = realValue(value: 95/2);
        let logoCenterX = whiteBackgroundW/2;
        let logoCenterY = realValue(value: 24/2) + logoH/2;
        logo.center = CGPoint(x: logoCenterX, y: logoCenterY);
        logo.bounds = CGRect(x: 0, y: 0, width: logoW, height: logoH);
        
        // 设置商户ID的frame
        let merchantIdViewW = realValue(value: 720/2);
        let merchantIdViewH = realValue(value: 100/2);
        let merchantIdViewCenterX = whiteBackgroundW/2;
        let merchantIdViewCenterY = logo.frame.maxY + realValue(value: 30/2) + merchantIdViewH/2;
        merchantIdView.center = CGPoint(x: merchantIdViewCenterX, y: merchantIdViewCenterY);
        merchantIdView.bounds = CGRect(x: 0, y: 0, width: merchantIdViewW, height: merchantIdViewH);
    
    
        // 设置accountView 的frame
        let accountViewW = merchantIdViewW;
        let accountViewH = merchantIdViewH;
        let accountViewCenterX = whiteBackgroundW/2;
        let accountViewCenterY = merchantIdView.frame.maxY + realValue(value: 30/2) + accountViewH/2;
        accountView.center = CGPoint.init(x: accountViewCenterX, y: accountViewCenterY);
        accountView.bounds = CGRect.init(x: 0, y: 0, width: accountViewW, height: accountViewH);
  
        
        // 设置passwordView 的frame
        let passwordViewW = accountViewW;
        let passwordViewH = accountViewH;
        let passwordViewCeneterX = accountViewCenterX;
        let passwordViewCeneterY = accountView.frame.maxY + realValue(value: 30/2) + passwordViewH/2;
        passwordView.center = CGPoint.init(x: passwordViewCeneterX, y: passwordViewCeneterY);
        passwordView.bounds = CGRect.init(x: 0, y: 0, width: passwordViewW, height: passwordViewH);

        
        // 设置登录按钮的frame
        let loginBtnCenterX = accountViewCenterX;
        let loginBtnCenterY = passwordView.frame.maxY + realValue(value: 40/2 + 100/2/2);
        let loginBtnW = accountViewW;
        let loginBtnH = accountViewH;
        loginBtn.center = CGPoint.init(x: loginBtnCenterX, y: loginBtnCenterY);
        loginBtn.bounds = CGRect.init(x: 0, y: 0, width: loginBtnW, height: loginBtnH);
        
        // 设置忘记密码的frame
        let forgetpasswordBtnY = loginBtn.frame.maxY + realValue(value: 30/2);
        let forgetpasswordBtnW = calculateWidth(title: "忘记密码？", fontSize: 36/2);
        let forgetpasswordBtnX = accountView.frame.maxX - realValue(value: 30/2) - forgetpasswordBtnW;
        let forgetpasswordBtnH = realValue(value: 36/2);
        forgetpasswordBtn.frame = CGRect.init(x: forgetpasswordBtnX, y: forgetpasswordBtnY, width: forgetpasswordBtnW, height: forgetpasswordBtnH);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
