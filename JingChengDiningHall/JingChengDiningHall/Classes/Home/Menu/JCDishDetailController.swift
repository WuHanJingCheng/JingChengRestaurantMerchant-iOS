//
//  JCDishDetailController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCDishDetailController: UIViewController {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "homeEdit_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 白色背景
    private lazy var whitebackground: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "homeEdit_white_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 标题
    private lazy var titleView: UILabel = {
        let label = UILabel();
        label.text = "修改菜品信息";
        label.font = Font(size: 48/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        return label;
    }();
    
    // 菜图片
    private lazy var dishImage: UIImageView = {
        let dishImage = UIImageView();
        dishImage.image = UIImage.imageWithName(name: "homeEdit_image");
        dishImage.isUserInteractionEnabled = true;
        return dishImage;
    }();
    
    // 菜品名称
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "菜品名称";
        label.textAlignment = .left;
        return label;
    }();
    
    // 菜品名称输入框
    private lazy var dishNameTextField: UITextField = {
        let textField = UITextField();
        textField.borderStyle = .none;
        textField.clearButtonMode = .whileEditing;
        textField.font = Font(size: 32/2);
        textField.textAlignment = .center;
        return textField;
    }();
    
    // 价格
    private lazy var dishPriceLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "价格";
        label.textAlignment = .left;
        return label;
    }();
    
    // 价格输入框
    private lazy var dishPriceTextField: UITextField = {
        let textField = UITextField();
        textField.borderStyle = .none;
        textField.clearButtonMode = .whileEditing;
        textField.font = Font(size: 32/2);
        textField.textAlignment = .center;
        return textField;
    }();
    
    // 菜品介绍
    private lazy var dishDesLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "介绍";
        label.textAlignment = .left;
        return label;
    }();
    
    // 菜品介绍输入框
    private lazy var dishDesTextField: UITextField = {
        let textField = UITextField();
        textField.borderStyle = .roundedRect;
        textField.clearButtonMode = .whileEditing;
        textField.font = Font(size: 28/2);
        return textField;
    }();
    
    // 取消按钮
    private lazy var cancellBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("取消", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.addTarget(self, action: #selector(cancellBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 确定按钮
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("确定", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.addTarget(self, action: #selector(submitBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 菜品名分割线
    private lazy var dishNameTextFieldBottomLine: UIImageView = {
        let line = UIImageView();
        line.image = UIImage.imageWithName(name: "homeEdit_cut_line");
        return line;
    }();
    
    // 价格分割线
    private lazy var dishPriceTextFieldBottomLine: UIImageView = {
        let line = UIImageView();
        line.image = UIImage.imageWithName(name: "homeEdit_cut_line");
        return line;
    }();
    
    // 取消回调
    var cancelCallBack: (() -> ())?;
    
    // 确定回调
    var submitCallBack: (() -> ())?;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加背景
        view.addSubview(background);
        
        // 添加whitebackground
        background.addSubview(whitebackground);
        
        // 添加标题
        whitebackground.addSubview(titleView);
        
        // 添加图片
        whitebackground.addSubview(dishImage);
        
        // 添加dishNameLabel
        whitebackground.addSubview(dishNameLabel);
        
        // 添加dishNameTextField
        whitebackground.addSubview(dishNameTextField);
        
        // 添加菜品名分割线
        whitebackground.addSubview(dishNameTextFieldBottomLine);
        
        // 添加dishPriceLabel
        whitebackground.addSubview(dishPriceLabel);
        
        // 添加dishPriceTextField
        whitebackground.addSubview(dishPriceTextField);
        
        // 添加价格分割线
        whitebackground.addSubview(dishPriceTextFieldBottomLine);
        
        // 添加dishDesLabel
        whitebackground.addSubview(dishDesLabel);
        
        // 添加dishDesTextField
        whitebackground.addSubview(dishDesTextField);
        
        // 添加cancellBtn
        whitebackground.addSubview(cancellBtn);
        
        // 添加submitBtn
        whitebackground.addSubview(submitBtn);
        
        // 给菜图片添加手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction));
        dishImage.addGestureRecognizer(tap);
    }
    
    // 点击图片打开相册
    func tapAction() -> Void {
        
        let albumListVc = AlbumListController();
        albumListVc.selectedImageCallBack = { [weak self]
            (image) in
            
            self?.dishImage.image = image;
        }
        let nav = UINavigationController(rootViewController: albumListVc);
        nav.navigationBar.setBackgroundImage(UIImage.imageWithName(name: "album_nav_background"), for: .default);
        present(nav, animated: true, completion: nil);
    }
    
    
    // MARK: - 监听取消点击
    func cancellBtnClick(button: UIButton) -> Void {
        
        if let cancelCallBack = cancelCallBack {
            cancelCallBack();
        }
    }
    
    // 监听确定点击
    func submitBtnClick(button: UIButton) -> Void {
        
        if let submitCallBack = submitCallBack {
            submitCallBack();
        }
    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        // 设置白色背景的frame
        let whitebackgroundCenterX = width/2;
        let whitebackgroundCenterY = height/2;
        let whitebackgroundW = realValue(value: 890/2);
        let whitebackgroundH = realValue(value: 934/2);
        whitebackground.center = CGPoint(x: whitebackgroundCenterX, y: whitebackgroundCenterY);
        whitebackground.bounds = CGRect(x: 0, y: 0, width: whitebackgroundW, height: whitebackgroundH);
        
        // titleView
        let titleViewX = realValue(value: 0);
        let titleViewY = realValue(value: 40/2);
        let titleViewW = whitebackgroundW;
        let titleViewH = realValue(value: 48/2);
        titleView.frame = CGRect(x: titleViewX, y: titleViewY, width: titleViewW, height: titleViewH);
        
        //  设置dishImage 的frame
        let dishImageW = realValue(value: 364/2);
        let dishImageH = realValue(value: 296/2);
        let dishImageX = (whitebackgroundW - dishImageW)/2;
        let dishImageY = titleView.frame.maxY + realValue(value: 60/2);
        dishImage.frame = CGRect(x: dishImageX, y: dishImageY, width: dishImageW, height: dishImageH);
        
        // 设置菜品名称的frame
        let dishNameLabelX = realValue(value: 60/2);
        let dishNameLabelY = dishImage.frame.maxY + realValue(value: 60/2);
        let dishNameLabelW = calculateWidth(title: dishNameLabel.text ?? "", fontSize: 32/2);
        let dishNameLabelH = realValue(value: 32/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置菜品名称的输入框的frame
        let dishNameTextFieldX = dishNameLabel.frame.maxX + realValue(value: 20/2);
        let dishNameTextFieldY = dishNameLabel.frame.minY - realValue(value: 10/2);
        let dishNameTextFieldW = whitebackgroundW - dishNameTextFieldX * CGFloat(2);
        let dishNameTextFieldH = dishNameLabelH + realValue(value: 10/2);
        dishNameTextField.frame = CGRect(x: dishNameTextFieldX, y: dishNameTextFieldY, width: dishNameTextFieldW, height: dishNameTextFieldH);
        
        // 菜品名分割线
        let dishNameTextFieldBottomLineX = dishNameTextFieldX;
        let dishNameTextFieldBottomLineY = dishNameTextField.frame.maxY + realValue(value: 1/2);
        let dishNameTextFieldBottomLineW = dishNameTextFieldW;
        let dishNameTextFieldBottomLineH = realValue(value: 1/2);
        dishNameTextFieldBottomLine.frame = CGRect(x: dishNameTextFieldBottomLineX, y: dishNameTextFieldBottomLineY, width: dishNameTextFieldBottomLineW, height: dishNameTextFieldBottomLineH);
        
        // 设置价格的frame
        let dishPriceLabelX = dishNameLabelX;
        let dishPriceLabelY = dishNameLabel.frame.maxY + realValue(value: 60/2);
        let dishPriceLabelW = dishNameLabelW;
        let dishPriceLabelH = dishNameLabelH;
        dishPriceLabel.frame = CGRect(x: dishPriceLabelX, y: dishPriceLabelY, width: dishPriceLabelW, height: dishPriceLabelH);
        
        // 设置价格输入框的frame
        let dishPriceTextFieldX = dishNameTextFieldX;
        let dishPriceTextFieldY = dishPriceLabel.frame.minY - realValue(value: 10/2);
        let dishPriceTextFieldW = dishNameTextFieldW;
        let dishPriceTextFieldH = dishNameTextFieldH;
        dishPriceTextField.frame =  CGRect(x: dishPriceTextFieldX, y: dishPriceTextFieldY, width: dishPriceTextFieldW, height: dishPriceTextFieldH);
        
        // 设置价格输入框的frame
        let dishPriceTextFieldBottomLineX = dishPriceTextFieldX;
        let dishPriceTextFieldBottomLineY = dishPriceTextField.frame.maxY + realValue(value: 1/2);
        let dishPriceTextFieldBottomLineW = dishPriceTextFieldW;
        let dishPriceTextFieldBottomLineH = realValue(value: 1/2);
        dishPriceTextFieldBottomLine.frame = CGRect(x: dishPriceTextFieldBottomLineX, y: dishPriceTextFieldBottomLineY, width: dishPriceTextFieldBottomLineW, height: dishPriceTextFieldBottomLineH);
        
        // 设置dishDesLabel 的frame
        let dishDesLabelX = dishNameLabelX;
        let dishDesLabelY = dishPriceLabel.frame.maxY + realValue(value: 60/2);
        let dishDesLabelW = dishNameLabelW;
        let dishDesLabelH = dishNameLabelH;
        dishDesLabel.frame = CGRect(x: dishDesLabelX, y: dishDesLabelY, width: dishDesLabelW, height: dishDesLabelH);
        
        // 设置dishDesTextField 的frame
        let dishDesTextFieldX = dishNameTextFieldX;
        let dishDesTextFieldY = dishDesLabel.frame.minY - realValue(value: 10/2);
        let dishDesTextFieldW = dishNameTextFieldW;
        let dishDesTextFieldH = realValue(value: 100/2);
        dishDesTextField.frame = CGRect(x: dishDesTextFieldX, y: dishDesTextFieldY, width: dishDesTextFieldW, height: dishDesTextFieldH);
        
        // 设置cancellBtn 的frame
        let cancellBtnX = realValue(value: 288/2);
        let cancellBtnY = dishDesTextField.frame.maxY + realValue(value: 60/2);
        let cancellBtnW = calculateWidth(title: "取消", fontSize: 36/2);
        let cancellBtnH = realValue(value: 36/2);
        cancellBtn.frame = CGRect(x: cancellBtnX, y: cancellBtnY, width: cancellBtnW, height: cancellBtnH);
        
        // 设置确定按钮的frame
        let submitBtnX = cancellBtn.frame.maxX + realValue(value: 170/2);
        let submitBtnY = cancellBtnY;
        let submitBtnW = calculateWidth(title: "确定", fontSize: 36/2);
        let submitBtnH = cancellBtnH;
        submitBtn.frame = CGRect(x: submitBtnX, y: submitBtnY, width: submitBtnW, height: submitBtnH);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
