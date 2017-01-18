//
//  JCUpLoadPopupView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/9.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCUpLoadPopupView: UIView {

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "uploadpopup_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // black 
    private lazy var blackView: UIImageView = {
        let blackView = UIImageView();
        blackView.image = UIImage.imageWithName(name: "uploadpopup_black");
        blackView.isUserInteractionEnabled = true;
        return blackView;
    }();
    
    // loadView
    private lazy var loadView: UIImageView = {
        let loadView = UIImageView();
        return loadView;
    }();
    
    // textLabel
    private lazy var textLabel: UILabel = {
        let label = UILabel();
        label.text = "正在上传";
        label.font = Font(size: 30/2);
        label.textColor = RGBWithHexColor(hexColor: 0xf6f6f6);
        return label;
    }();
    
    
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加black
        background.addSubview(blackView);
        
        // 添加loadView
        blackView.addSubview(loadView);
        
        // 添加textLabel
        blackView.addSubview(textLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 正在上传
    func loadingImage() -> Void {
        
        let image = UIImage.sd_animatedGIFNamed("loading");
        loadView.image = image;
        textLabel.text = "正在上传";
        
    }
    
    // 上传失败
    func uploadFailure() -> Void {
        
        loadView.image = UIImage.imageWithName(name: "uploadpopup_failure");
        textLabel.text = "上传失败";
    }
    
    // 上传成功
    func uploadSuccess() -> Void {
        
        loadView.image = UIImage.imageWithName(name: "uploadpopup_success");
        textLabel.text = "上传成功";
    }
    
    
    // 正在修改
    func modifitingImage() -> Void {
        
        let image = UIImage.sd_animatedGIFNamed("loading");
        loadView.image = image;
        textLabel.text = "正在修改";
    }
    
    // 修改成功
    func modifitySuccess() -> Void {
        
        loadView.image = UIImage.imageWithName(name: "uploadpopup_success");
        textLabel.text = "修改成功";
    }
    
    // 修改失败
    func modifityFailure() -> Void {
        
        loadView.image = UIImage.imageWithName(name: "uploadpopup_failure");
        textLabel.text = "修改失败";
    }
    
    // 正在删除
    func deletingImage() -> Void {
        
        let image = UIImage.sd_animatedGIFNamed("loading");
        loadView.image = image;
        textLabel.text = "正在删除";
    }
    
    // 删除成功
    func deleteSuccess() -> Void {
        
        loadView.image = UIImage.imageWithName(name: "uploadpopup_success");
        textLabel.text = "删除成功";
    }
    
    // 删除失败
    func deleteFailure() -> Void {
        
        loadView.image = UIImage.imageWithName(name: "uploadpopup_failure");
        textLabel.text = "删除失败";
    }
    
   
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置background 的frame
        background.frame = bounds;
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置blackView 的frame
        let blackViewW = realValue(value: 336/2);
        let blackViewH = realValue(value: 148/2);
        let blackViewX = (width - blackViewW)/2;
        let blackViewY = (height - blackViewH)/2;
        blackView.frame = CGRect(x: blackViewX, y: blackViewY, width: blackViewW, height: blackViewH);
        
        // 设置loadView 的frame
        let loadViewW = realValue(value: 100/2);
        let loadViewH = realValue(value: 100/2);
        let loadViewX = realValue(value: 40/2);
        let loadViewY = (blackViewH - loadViewH)/2;
        loadView.frame = CGRect(x: loadViewX, y: loadViewY, width: loadViewW, height: loadViewH);
        
        // 设置textLabel 的frame
        let textLabelW = calculateWidth(title: textLabel.text ?? "", fontSize: 30/2);
        let textLabelH = realValue(value: 30/2);
        let textLabelX = loadView.frame.maxX + realValue(value: 40/2);
        let textLabelY = (blackViewH - textLabelH)/2;
        textLabel.frame = CGRect(x: textLabelX, y: textLabelY, width: textLabelW, height: textLabelH);
        
    }
}
