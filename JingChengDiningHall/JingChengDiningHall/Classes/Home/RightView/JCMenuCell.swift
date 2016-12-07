//
//  JCRightCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCMenuCell: UICollectionViewCell {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "rightCell_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 菜图片
    private lazy var icon: UIImageView = UIImageView();
    
    // 菜名
    private lazy var dishNameLabel: UILabel = {
        let dishNameLabel = UILabel();
        dishNameLabel.text = "鱼香肉丝";
        dishNameLabel.textAlignment = .left;
        dishNameLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        dishNameLabel.font = Font(size: 36/2);
        return dishNameLabel;
    }();
    
    // 菜价格
    private lazy var dishPriceLabel: UILabel = {
        let dishPriceLabel = UILabel();
        dishPriceLabel.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        dishPriceLabel.font = Font(size: 36/2);
        dishPriceLabel.textAlignment = .left;
        dishPriceLabel.text = "$19.99";
        return dishPriceLabel;
    }();

    
    // 编辑
    private lazy var editBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "homeEdit_editBtn"), for: .normal);
        button.addTarget(self, action: #selector(editBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 删除
    private lazy var deleteBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "homeEdit_deleteBtn"), for: .normal);
        button.addTarget(self, action: #selector(deleteBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 编辑闭包
    var editBtnCallBack: ((_ model: JCMenuModel) -> ())?;
    
    // 删除闭包
    var deleteBtnCallBack: ((_ model: JCMenuModel) -> ())?;
    
    // 数据模型
    var menuModel: JCMenuModel? {
        didSet {
            // 取出可选类型中的数据
            guard let menuModel = menuModel else {
                return;
            }
            
        }
    }
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        contentView.addSubview(background);
        
        // 添加菜图片
        icon.image = UIImage.imageWithName(name: "menu_icon");
        background.addSubview(icon);
        
        // 添加菜名
        background.addSubview(dishNameLabel);
        
        // 添加菜价格
        background.addSubview(dishPriceLabel);
        
        // 添加编辑按钮
        background.addSubview(editBtn);
        
        // 添加删除按钮
        background.addSubview(deleteBtn);
   
    }
    
    // MARK: - 编辑
    func editBtnClick(button: UIButton) -> Void {
        
        if let editBtnCallBack = editBtnCallBack, let menuModel = menuModel {
            editBtnCallBack(menuModel);
        }
    }
    
    // MARK: - 删除
    func deleteBtnClick(button: UIButton) -> Void {
        
        if let deleteBtnCallBack = deleteBtnCallBack, let menuModel = menuModel {
            deleteBtnCallBack(menuModel);
        }
    }
  
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置图片的frame
        let iconX = realValue(value: 17/2);
        let iconY = realValue(value: 16/2);
        let iconW = realValue(value: 476/2);
        let iconH = realValue(value: 386/2);
        icon.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH);
        
        // 设置dishNameLabel 的frame
        let dishNameLabelX = iconX;
        let dishNameLabelY = icon.frame.maxY + realValue(value: 30/2);
        let dishNameLabelW = iconW;
        let dishNameLabelH = realValue(value: 36/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置dishPriceLabel 的frame
        let dishPriceLabelX = iconX;
        let dishPriceLabelY = dishNameLabel.frame.maxY + realValue(value: 46/2);
        let dishPriceLabelW = iconW;
        let dishPriceLabelH = realValue(value: 36/2);
        dishPriceLabel.frame = CGRect(x: dishPriceLabelX, y: dishPriceLabelY, width: dishPriceLabelW, height: dishPriceLabelH);
        
        // 设置编辑按钮的frame
        let editBtnX = width - realValue(value: 53/2);
        let editBtnY = icon.frame.maxY + realValue(value: 70/2);
        let editBtnW = realValue(value: 36/2);
        let editBtnH = realValue(value: 40/2);
        editBtn.frame = CGRect(x: editBtnX,y : editBtnY, width: editBtnW, height: editBtnH);
        
        // 设置删除按钮的frame
        let deleteBtnX = editBtn.frame.minX - realValue(value: 73/2);
        let deleteBtnY = editBtnY;
        let deleteBtnW = editBtnW;
        let deleteBtnH = editBtnH;
        deleteBtn.frame = CGRect(x: deleteBtnX, y: deleteBtnY, width: deleteBtnW, height: deleteBtnH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
