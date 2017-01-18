//
//  JCAddSubMenuDetailView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/20.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCAddSubMenuDetailView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "addSubMenuDetail_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 添加分类
    private lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.text = "添加分类";
        label.textAlignment = .center;
        label.font = Font(size: 40/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 未选中状态背景
    private lazy var background_normal: UIImageView = {
        let background_normal = UIImageView();
        background_normal.image = UIImage.imageWithName(name: "addSubMenuDetail_icon_backgroun_normal");
        background_normal.isUserInteractionEnabled = true;
        return background_normal;
    }();
    
    // 未来选中状态图片
    private lazy var normal_btn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "addSubMenuDetail_normal_btn"), for: .normal);
        button.clipsToBounds = true;
        button.addTarget(self, action: #selector(normalBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 未选中状态文字
    private lazy var normal_label: UILabel = {
        let label = UILabel();
        label.font = Font(size: 24/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        label.text = "未选中状态";
        return label;
    }();
    
    
    // 选中状态背景
    private lazy var background_selected: UIImageView = {
        let background_selected = UIImageView();
        background_selected.image = UIImage.imageWithName(name: "addSubMenuDetail_icon_backgroun_normal");
        background_selected.isUserInteractionEnabled = true;
        return background_selected;
    }();
    
    // 选中状态图片
    private lazy var selected_btn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "addSubMenuDetail_selected_btn"), for: .normal);
        button.clipsToBounds = true;
        button.addTarget(self, action: #selector(seletedBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 选中状态的文字
    private lazy var selected_label: UILabel = {
        let label = UILabel();
        label.font = Font(size: 24/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        label.text = "选中状态";
        return label;
    }();
    
    // 提示上传图片
    private lazy var hintImage: JCHintLabel = {
        let hintImage = JCHintLabel();
        hintImage.text = "请上传图片";
        hintImage.isHidden = true;
        return hintImage;
    }();
    
    
    // 分类名称
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        label.text = "分类名称";
        return label;
    }();
    
    // 分类名称输入框
    lazy var categoryNameTextField: UITextField = {
        let textField = UITextField();
        textField.background = UIImage.imageWithName(name: "addSubMenuDetail_categoryTextField");
        textField.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        textField.textAlignment = .center;
        textField.font = Font(size: 32/2);
        textField.clearButtonMode = .whileEditing;
        textField.borderStyle = .none;
        return textField;
    }();
    
    // 提示输入分类名
    private lazy var hintCategoryName: JCHintLabel = {
        let hintCategoryName = JCHintLabel();
        hintCategoryName.text = "请输入分类";
        hintCategoryName.isHidden = true;
        return hintCategoryName;
    }();
    
    
    // 取消
    lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("取消", for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.addTarget(self, action: #selector(cancleBtnClick), for: .touchUpInside);
        return button;
    }();
    
    // 确定
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("确定", for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.addTarget(self, action: #selector(submitBtnClick), for: .touchUpInside);
        return button;
    }();
    
    
    var model: JCMiddleModel? {
        didSet {
            // 获取可选类型中的数据
            guard let model = model else {
                return;
            }
            
            if let imageType = model.imageType {
                if imageType == .normal {
                    if let image_normal_data = model.image_normal_data {
                        normal_btn.setImage(UIImage.init(data: image_normal_data), for: .normal);
                    }
                    
                } else {
                    
                    if let image_selected_data = model.image_selected_data {
                        
                        selected_btn.setImage(UIImage.init(data: image_selected_data), for: .normal);
                    }
                }
            }
        }
    }
    
    
    // 打开相册的回调
    var openAlbumCallBack: ((_ imageType: ImageType) -> ())?;
    // 取消按钮回调
    var cancelBtnCallBack: (() -> ())?;
    // 确定按钮的回调
    var submitBtnCallBack: (() -> ())?;
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加分类标题
        background.addSubview(titleLabel);
        
        // 添加未选中状态的背景
        background.addSubview(background_normal);
        
        // 添加未选中状态的图标
        background_normal.addSubview(normal_btn);
        
        // 添加未选中状态的文字
        background.addSubview(normal_label);
        
        // 添加选中状态的背景
        background.addSubview(background_selected);
        
        // 添加选中状态的图标
        background_selected.addSubview(selected_btn);
        
        // 添加选中状态的文字
        background.addSubview(selected_label);
        
        // 添加提示上传图片
        background.addSubview(hintImage);
        
        // 添加分类名称
        background.addSubview(categoryNameLabel);
        
        // 添加分类名称输入框
        background.addSubview(categoryNameTextField);
        
        // 添加提示输入分类名
        background.addSubview(hintCategoryName);
        
        // 添加取消按钮
        background.addSubview(cancelBtn);
        
        // 添加确定按钮
        background.addSubview(submitBtn);
        
    
    }
    
    // 展示子菜单信息
    func showSubMenuInfo(model: JCMiddleModel) -> Void {
        
        if let PictureUrl = model.PictureUrl {
            
            normal_btn.zx_setImage(urlString: PictureUrl, for: .normal, placeholderImageName: "addSubMenuDetail_normal_btn");
        }
        
        if let PictureUrlSelected = model.PictureUrlSelected {
            
            selected_btn.zx_setImage(urlString: PictureUrlSelected, for: .normal, placeholderImageName: "addSubMenuDetail_selected_btn");
        }
        
        if let MenuName = model.MenuName {
            categoryNameTextField.text = MenuName;
        }
    }
    
    // 监听普通状态按钮的点击
    @objc private func normalBtnClick() {
        
        let imageType: ImageType = .normal;
        if let openAlbumCallBack = openAlbumCallBack {
            openAlbumCallBack(imageType);
        }
    }
    
    // 监听选中状态按钮的点击
    func seletedBtnClick() {
        
        let imageType: ImageType = .selected;
        if let openAlbumCallBack = openAlbumCallBack {
            openAlbumCallBack(imageType);
        }
    }
    
    // 点击取消按钮，隐藏弹框
    @objc private func cancleBtnClick() {
        
        if let cancelBtnCallBack = cancelBtnCallBack {
            cancelBtnCallBack();
        }
    }
    
    // 监听确定按钮的点击
    @objc private func submitBtnClick() {
        
        if let submitBtnCallBack = submitBtnCallBack {
            submitBtnCallBack();
        }
    }
    
    // 判断交互,提示上传图片和分类
    func controlHintInfo() -> Bool {
        
        // 图片状态的图片不能为空
        let image_normal = normal_btn.image(for: .normal);
        let image_selected = selected_btn.image(for: .normal);
        if image_normal == UIImage.imageWithName(name: "addSubMenuDetail_normal_btn") || image_selected == UIImage.imageWithName(name: "addSubMenuDetail_selected_btn") {
            
            hintImage.isHidden = false;
            delayCallBack(1, callBack: {
                
                self.hintImage.isHidden = true;
            })
            return false;
            
        }
        // 分类不能为空
         if let categoryName = categoryNameTextField.text, categoryName.characters.count != 0 {
            
            return true;
         } else {
            
            hintCategoryName.isHidden = false;
            delayCallBack(1, callBack: {
                
                self.hintCategoryName.isHidden = true;
            })
            return false;
        }
    }
    
   
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置background 的frame
        background.frame = bounds;
        
        // 设置titleLabel 的frame
        let titleLabelCenterX = width/2;
        let titleLabelCenterY = realValue(value: 48/2 + 40/2/2);
        let titleLabelW = width;
        let titleLabelH = realValue(value: 40/2);
        titleLabel.center = CGPoint(x: titleLabelCenterX, y: titleLabelCenterY);
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleLabelW, height: titleLabelH);
        
        // 设置未选中状态的背景
        let background_normalX = realValue(value: 164/2);
        let background_normalY = titleLabel.frame.maxY + realValue(value: 60/2);
        let background_normalW = realValue(value: 196/2);
        let background_normalH = background_normalW;
        background_normal.frame = CGRect(x: background_normalX, y: background_normalY, width: background_normalW, height: background_normalH);
        
        // 设置未选中状态的图标
        let normal_btnW = realValue(value: 84/2);
        let normal_btnH = realValue(value: 64/2);
        let normal_btnX = (background_normalW - normal_btnW)/2;
        let normal_btnY = (background_normalH - normal_btnH)/2;
        normal_btn.frame = CGRect(x: normal_btnX, y: normal_btnY, width: normal_btnW, height: normal_btnH);
        
        // 设置未选中状态的文字
        let normal_labelX = background_normalX;
        let normal_labelY = background_normal.frame.maxY + realValue(value: 20/2);
        let normal_labelW = background_normalW;
        let normal_labelH = realValue(value: 24/2);
        normal_label.frame = CGRect(x: normal_labelX, y: normal_labelY, width: normal_labelW, height: normal_labelH);
        
        
        // 设置选中状态的背景
        let background_selectedX = width - background_normalW - realValue(value: 164/2);
        let background_selectedY = background_normalY;
        let background_selectedW = background_normalW;
        let background_selectedH = background_normalH;
        background_selected.frame = CGRect(x: background_selectedX, y: background_selectedY, width: background_selectedW, height: background_selectedH);
        
        // 设置选中状态的图标
        selected_btn.frame = normal_btn.frame;
        
        // 设置选中状态的文字
        let selected_labelX = background_selectedX;
        let selected_labelY = normal_labelY;
        let selected_labelW = background_selectedW;
        let selected_labelH = normal_labelH;
        selected_label.frame = CGRect(x: selected_labelX, y: selected_labelY, width: selected_labelW, height: selected_labelH);
        
        // 设置提示上传图片的frame
        let hintImageW = realValue(value: 164/2);
        let hintImageH = realValue(value: 30/2);
        let hintImageX = (width - hintImageW)/2;
        let hintImageY = normal_label.frame.maxY + realValue(value: 15/2);
        hintImage.frame = CGRect(x: hintImageX, y: hintImageY, width: hintImageW, height: hintImageH);
        
        
        // 设置categoryNameLabel 的frame
        let categoryNameLabelX = realValue(value: 177/2);
        let categoryNameLabelY = normal_label.frame.maxY + realValue(value: 60/2);
        let categoryNameLabelW = calculateWidth(title: "分类名称", fontSize: 32/2);
        let categoryNameLabelH = realValue(value: 32/2);
        categoryNameLabel.frame = CGRect(x: categoryNameLabelX, y: categoryNameLabelY, width: categoryNameLabelW, height: categoryNameLabelH);
        
        // 设置categoryNameTextField 的frame
        let categoryNameTextFieldX = categoryNameLabel.frame.maxX + realValue(value: 20/2);
        let categoryNameTextFieldY = categoryNameLabelY;
        let categoryNameTextFieldW = width - categoryNameTextFieldX - categoryNameLabelX;
        let categoryNameTextFieldH = realValue(value: 32/2);
        categoryNameTextField.frame = CGRect(x: categoryNameTextFieldX, y: categoryNameTextFieldY, width: categoryNameTextFieldW, height: categoryNameTextFieldH);
        
        // 提示上传分类
        let hintCategoryNameW = hintImageW;
        let hintCategoryNameH = hintImageH;
        let hintCategoryNameX = hintImageX;
        let hintCategoryNameY = categoryNameTextField.frame.maxY + realValue(value: 15/2);
        hintCategoryName.frame = CGRect(x: hintCategoryNameX, y: hintCategoryNameY, width: hintCategoryNameW, height: hintCategoryNameH);
        
        
        // 设置cancelBtn 的frame 
        let cancelBtnX = realValue(value: 285/2);
        let cancelBtnY = categoryNameLabel.frame.maxY + realValue(value: 60/2);
        let cancelBtnW = calculateWidth(title: "取消", fontSize: 36/2);
        let cancelBtnH = realValue(value: 36/2);
        cancelBtn.frame = CGRect(x: cancelBtnX, y: cancelBtnY, width: cancelBtnW, height: cancelBtnH);
        
        // 设置submitBtn 的frame
        let submitBtnW = calculateWidth(title: "确定", fontSize: 36/2);
        let submitBtnX = width - realValue(value: 285/2) - submitBtnW;
        let submitBtnY = cancelBtnY;
        let submitBtnH = cancelBtnH;
        submitBtn.frame = CGRect(x: submitBtnX, y: submitBtnY, width: submitBtnW, height: submitBtnH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
