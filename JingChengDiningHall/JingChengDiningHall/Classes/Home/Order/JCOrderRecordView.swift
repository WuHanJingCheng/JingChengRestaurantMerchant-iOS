//
//  JCOrderRecordView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let recordInsetMargin = realValue(value: 20/2);

class JCOrderRecordView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // cell表示符号
    private let orderRecordCellIdentifier = "orderRecordCellIdentifier";

    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "order_background_left");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // collectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: realValue(value: 308/2), height: realValue(value: 255/2));
        layout.minimumLineSpacing = realValue(value: 40/2);
        layout.minimumInteritemSpacing = realValue(value: 52/2);
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout);
        collectionView.contentInset = UIEdgeInsets(top: recordInsetMargin, left: recordInsetMargin, bottom: recordInsetMargin, right: recordInsetMargin);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.clear;
        return collectionView;
    }();
    
    // 数组
    private lazy var orderRecordModelArray: [JCOrderRecordModel] = [JCOrderRecordModel]();
    
 
    
    // MARK: - 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加collectionView
        addSubview(collectionView);
        
        // 注册cell
        collectionView.register(JCOrderRecordCell.self, forCellWithReuseIdentifier: orderRecordCellIdentifier);
        
        // 加载数据
        setData();
        
    }
    
    // MARK: - 加载数据
    func setData() -> Void {
        
        for i in 0..<20 {
            let model = JCOrderRecordModel();
            model.isSelected = (i==0) ? true : false;
            orderRecordModelArray.append(model);
        }
        
        // 刷新数据
        collectionView.reloadData();
    }
    
    // MARK: - 返回行
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    // MARK: - 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderRecordCellIdentifier, for: indexPath) as? JCOrderRecordCell;
        let orderRecordModel = orderRecordModelArray[indexPath.row];
        cell?.orderRecordModel = orderRecordModel;
        return cell!;
    }
    
    // MARK: - 选中cell改变cell背景
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 先将所有Model中的isSelected 置为false
        for model in orderRecordModelArray {
            model.isSelected = false;
        }
        
        let orderRecordModel = orderRecordModelArray[indexPath.row];
        orderRecordModel.isSelected = true;
        
        // 刷新表格
        collectionView.reloadData();
        
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        // 设置background 的frame
        background.frame = bounds;
        
        // 设置collectionView 的frame
        let collectionViewX = realValue(value: 0);
        let collectionViewY = realValue(value: 0);
        let collectionViewW = width - collectionViewX * CGFloat(2);
        let collectionViewH = height - collectionViewY;
        collectionView.frame = CGRect(x: collectionViewX, y: collectionViewY, width: collectionViewW, height: collectionViewH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
