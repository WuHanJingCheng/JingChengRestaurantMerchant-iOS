//
//  JCForbidView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/19.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCForbidView: UIView {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "forbid_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();

    // 卓号
    private lazy var tableLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 40/2);
        label.text = "桌号：001号";
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 停用状态
    private lazy var forbidStatusLabel: UILabel = {
        let label = UILabel();
        label.text = "停用此桌";
        label.font = Font(size: 36/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        return label;
    }();
    
    // 开关按钮
    private lazy var switchBtn: UISwitch = {
        let switchBtn = UISwitch();
        switchBtn.isOn = true;
        switchBtn.tintColor = UIColor.clear;
        switchBtn.onTintColor = UIColor.green;
        switchBtn.backgroundColor = RGBWithHexColor(hexColor: 0xc5c5c5);
        switchBtn.layer.masksToBounds = true;
        switchBtn.layer.cornerRadius = realValue(value: 31/2);
        switchBtn.addTarget(self, action: #selector(switchBtnClick(switchBtn:)), for: .valueChanged);
        return switchBtn;
    }();
    
    // 人
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage.imageWithName(name: "person_free");
        return imageView;
    }();
    
    // 此桌还未开台
    private lazy var desLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 48/2);
        label.textColor = RGBWithHexColor(hexColor: 0x343434);
        label.textAlignment = .center;
        label.text = "此桌还未开台!";
        return label;
    }();
    
    
    var model: JCOrderModel? {
        didSet {
            // 获取可选类型中的数据
            guard let model = model else {
                return;
            }
            
            // 桌号
            if let tableNumber = model.tableNumber {
                tableLabel.text = "\(tableNumber)";
            }
            
            
            if model.tag == 1 {
                // 空闲
                forbidStatusLabel.text = "停用此桌";
                switchBtn.isOn = true;
                personImageView.image = UIImage.imageWithName(name: "person_free");
                desLabel.text = "此桌还未开台！";
            } else if model.tag == 2 {
                forbidStatusLabel.text = "启用此桌";
                switchBtn.isOn = false;
                personImageView.image = UIImage.imageWithName(name: "person_forbid");
                desLabel.text = "此桌已停用!";
            }
            
        }
    }
    
    // 更新桌子的状态
    var orderTableCallBack: ((_ model: JCOrderModel) -> ())?;
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加桌号
        background.addSubview(tableLabel);
        
        // 停用状态
        background.addSubview(forbidStatusLabel);
        
        // 开关按钮
        background.addSubview(switchBtn);
        
        // 添加人
        background.addSubview(personImageView);
        
        // 添加desLabel 
        background.addSubview(desLabel);
        
    }
    
    // 监听值改变
    func switchBtnClick(switchBtn: UISwitch) -> Void {
        
        if switchBtn.isOn == true {
            // 开着的状态时，为空闲
            forbidStatusLabel.text = "停用此桌";
            switchBtn.isOn = true;
            personImageView.image = UIImage.imageWithName(name: "person_free");
            desLabel.text = "此桌还未开台！";
            model?.tag = 1;
            
        } else {
            // 关着的状态时，为停用
            forbidStatusLabel.text = "启用此桌";
            switchBtn.isOn = false;
            personImageView.image = UIImage.imageWithName(name: "person_forbid");
            desLabel.text = "此桌已停用!";
            model?.tag = 2;
        }
        
        // 更新桌子状态
        if let orderTableCallBack = orderTableCallBack, let model = model {
            orderTableCallBack(model);
        }
    }
    
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置桌号的frame
        let tableLabelX = realValue(value: 30/2);
        let tableLabelY = realValue(value: 40/2);
        let tableLabelW = width - tableLabelX * CGFloat(2);
        let tableLabelH = realValue(value: 40/2);
        tableLabel.frame = CGRect(x: tableLabelX, y: tableLabelY, width: tableLabelW, height: tableLabelH);
        
        // 设置停用状态的frame
        let forbidStatusLabelX = tableLabelX;
        let forbidStatusLabelY = tableLabel.frame.maxY + realValue(value: 40/2);
        let forbidStatusLabelW = calculateWidth(title: forbidStatusLabel.text ?? "", fontSize: 36/2);
        let forbidStatusLabelH = realValue(value: 36/2);
        forbidStatusLabel.frame = CGRect(x: forbidStatusLabelX, y: forbidStatusLabelY, width: forbidStatusLabelW, height: forbidStatusLabelH);
        
        // 设置switchBtn 的frame
        let switchBtnW = realValue(value: 84/2);
        let switchBtnH = realValue(value: 42/2);
        let switchBtnX = width - realValue(value: 44/2 + 84/2);
        let switchBtnY = realValue(value: 100/2);
        switchBtn.frame = CGRect(x: switchBtnX, y: switchBtnY, width: switchBtnW, height: switchBtnH);
        
        // 设置人的frame
        let personImageViewW = realValue(value: 210/2);
        let personImageViewH = realValue(value: 374/2);
        let personImageViewX = (width - personImageViewW)/2;
        let personImageViewY = forbidStatusLabel.frame.maxY + realValue(value: 305/2);
        personImageView.frame = CGRect(x: personImageViewX, y: personImageViewY, width: personImageViewW, height: personImageViewH);
        
        // 设置desLabel 的frame
        let desLabelX = realValue(value: 0);
        let desLabelY = personImageView.frame.maxY + realValue(value: 20/2);
        let desLabelW = width;
        let desLabelH = realValue(value: 48/2);
        desLabel.frame = CGRect(x: desLabelX, y: desLabelY, width: desLabelW, height: desLabelH);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
