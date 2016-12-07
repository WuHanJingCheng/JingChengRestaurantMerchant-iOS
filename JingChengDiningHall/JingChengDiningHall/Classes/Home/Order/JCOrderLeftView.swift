//
//  JCOrderLeftView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let orderLeftInsetMargin = realValue(value: 30/2);

class JCOrderLeftView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private let orderLeftCellIdentifier = "orderLeftCellIdentifier";
    
    // 数组
    lazy var orderModelArray: [JCOrderModel] = [JCOrderModel]();
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "order_background_left");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 2人桌
    private lazy var twoTableBtn: UIButton = {
        let button = UIButton.buttonWithTitle(title: "2人桌");
        return button;
    }();
    
    // 4人桌
    private lazy var fourTableBtn: UIButton = {
        let button = UIButton.buttonWithTitle(title: "4人桌");
        return button;
    }();
    
    //  6人桌
    private lazy var sixTableBtn: UIButton = {
        let button = UIButton.buttonWithTitle(title: "其他");
        return button;
    }();
    
    // 添加桌子
    private lazy var addTableBtn: JCStatusView = {
        let statusView = JCStatusView();
        let image = UIImage.imageWithName(name: "order_add");
        statusView.icon.image = image;
        statusView.iconW = realValue(value: 36/2);
        statusView.iconH = statusView.iconW;
        statusView.layoutIfNeeded();
        statusView.title.text = "添加";
        return statusView;
    }();
    
    // 就餐中状态
    private lazy var dinnerBtn: JCStatusView = {
        let statusView = JCStatusView();
        statusView.icon.image = UIImage.imageWithName(name: "order_dinner_small");
        statusView.title.text = "就餐中";
        statusView.iconW = realValue(value: 35/2);
        statusView.iconH = realValue(value: 27/2);
        statusView.layoutIfNeeded();
        return statusView;
    }();
    
    // 空闲状态
    private lazy var freeBtn: JCStatusView = {
        let statusView = JCStatusView();
        statusView.icon.image = UIImage.imageWithName(name: "order_free_small");
        statusView.title.text = "空闲";
        statusView.iconW = realValue(value: 19/2);
        statusView.iconH = realValue(value: 28/2);
        statusView.layoutIfNeeded();
        return statusView;
    }();
    
    // 桌号列表
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: realValue(value: 177/2), height: realValue(value: 207/2));
        layout.minimumLineSpacing = realValue(value: 100/2);
        layout.minimumInteritemSpacing = realValue(value: 100/2);
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.contentInset = UIEdgeInsets(top: orderLeftInsetMargin, left: orderLeftInsetMargin, bottom: orderLeftInsetMargin, right: orderLeftInsetMargin);
        collectionView.backgroundColor = UIColor.clear;
        return collectionView;
    }();
    
  
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加2人桌按钮
        background.addSubview(twoTableBtn);
        
        // 添加4人桌
        background.addSubview(fourTableBtn);
        
        // 添加6人桌
        background.addSubview(sixTableBtn);
        
        // 添加添加按钮
        background.addSubview(addTableBtn);
        
        // 添加就餐状态
        background.addSubview(dinnerBtn);
        
        // 添加空闲状态
        background.addSubview(freeBtn);
        
        // 添加桌号列表
        background.addSubview(collectionView);
        
        // 注册cell
        collectionView.register(JCOrderLeftCell.self, forCellWithReuseIdentifier: orderLeftCellIdentifier);
        
        setData();
    }
    
    func setData() -> Void {
        
        for i in 0..<20 {
            let model = JCOrderModel();
            model.isSelected = (i==0) ? true : false;
            orderModelArray.append(model);
        }
        
        // 刷新数据
        collectionView.reloadData();
    }
    
    // MARK: - 返回行
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderModelArray.count;
    }
    
    // MARK: - 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderLeftCellIdentifier, for: indexPath) as?JCOrderLeftCell;
        let orderModel = orderModelArray[indexPath.row];
        cell?.orderModel = orderModel;
        
        return cell!;
    }
    
    // MARK: - 选中cell, 改变cell状态，显示对应桌号的订单详情
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 先将所有的isSelected 置为false
        for model in orderModelArray {
            model.isSelected = false;
        }
        // 将选中状态置为true
        let orderModel = orderModelArray[indexPath.row];
        orderModel.isSelected = true;
        
        // 刷新表格
        collectionView.reloadData();
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置背景的frame
        background.frame = bounds;
        
        // 设置twoTableBtn 的frame
        let twoTableBtnX = realValue(value: 30/2);
        let twoTableBtnY = realValue(value: 10/2);
        let twoTableBtnW = realValue(value: 125/2);
        let twoTableBtnH = realValue(value: 48/2);
        twoTableBtn.frame = CGRect(x: twoTableBtnX, y: twoTableBtnY, width: twoTableBtnW, height: twoTableBtnH);
        
        // 设置fourTableBtn 的frame
        let fourTableBtnX = twoTableBtn.frame.maxX + realValue(value: 30/2);
        let fourTableBtnY = twoTableBtnY;
        let fourTableBtnW = twoTableBtnW;
        let fourTableBtnH = twoTableBtnH;
        fourTableBtn.frame = CGRect(x: fourTableBtnX, y: fourTableBtnY, width: fourTableBtnW, height: fourTableBtnH);
        
        // 设置sixTableBtn 的frame
        let sixTableBtnX = fourTableBtn.frame.maxX + realValue(value: 30/2);
        let sixTableBtnY = twoTableBtnY;
        let sixTableBtnW = twoTableBtnW;
        let sixTableBtnH = twoTableBtnH;
        sixTableBtn.frame = CGRect(x: sixTableBtnX, y: sixTableBtnY, width: sixTableBtnW, height: sixTableBtnH);
        
        // 设置addTableBtn 的frame
        let addTableBtnX = sixTableBtn.frame.maxX + realValue(value: 60/2);
        let addTableBtnY = twoTableBtnY;
        let addTableBtnW = addTableBtn.calculateStatusWidth(text: addTableBtn.title.text!);
        let addTableBtnH = realValue(value: 48/2);
        addTableBtn.frame = CGRect(x: addTableBtnX, y: addTableBtnY, width: addTableBtnW, height: addTableBtnH);
        
        // 设置dinnerBtn 的frame
        let dinnerBtnX = addTableBtn.frame.maxX + realValue(value: 106/2);
        let dinnerBtnY = addTableBtnY;
        let dinnerBtnW = dinnerBtn.calculateStatusWidth(text: dinnerBtn.title.text!);
        let dinnerBtnH = addTableBtnH;
        dinnerBtn.frame = CGRect(x: dinnerBtnX, y: dinnerBtnY, width: dinnerBtnW, height: dinnerBtnH);
        
        // 设置freeBtn 的frame
        let freeBtnX = dinnerBtn.frame.maxX + realValue(value: 40/2);
        let freeBtnY = addTableBtnY;
        let freeBtnW = freeBtn.calculateStatusWidth(text: freeBtn.title.text!);
        let freeBtnH = addTableBtnH;
        freeBtn.frame = CGRect(x: freeBtnX, y: freeBtnY, width: freeBtnW, height: freeBtnH);
        
        // 设置collectionView 的frame
        let collectionViewX = realValue(value: 0);
        let collectionViewY = twoTableBtn.frame.maxY + realValue(value: 30/2);
        let collectionViewW = width - collectionViewX * CGFloat(2);
        let collectionViewH = height - collectionViewY;
        collectionView.frame = CGRect(x: collectionViewX, y: collectionViewY, width: collectionViewW, height: collectionViewH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
