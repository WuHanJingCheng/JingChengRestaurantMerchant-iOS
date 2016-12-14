//
//  JCMenuView.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let menuInsetMargin = realValue(value: 10/2);

class JCMenuView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private let rightCellIdentifier = "rightCellIdentifier";
    private let rightAddCellIdentifier = "rightAddCellIdentifier";
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.isUserInteractionEnabled = true;
        background.image = UIImage.imageWithName(name: "right_background");
        return background;
    }();
    // 九宫格视图
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: realValue(value: 510/2), height: realValue(value: 576/2));
        layout.minimumLineSpacing = realValue(value: 37/2);
        layout.minimumInteritemSpacing = realValue(value: 37/2);
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.clear;
        collectionView.contentInset = UIEdgeInsets(top: menuInsetMargin, left: menuInsetMargin, bottom: menuInsetMargin, right: menuInsetMargin);
        return collectionView;
    }();
    
    // 数组
    lazy var menuModelArray: [JCMenuModel] = [JCMenuModel]();
    
    // 添加按钮的回调
    var addDishCallBack: (() -> ())?;
    // 编辑的回调
    var editBtnCallBack: (() -> ())?;
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加背景
        addSubview(background);
        
        // 添加collectionView
        background.addSubview(collectionView);
        
        // 注册cell
        collectionView.register(JCMenuCell.self, forCellWithReuseIdentifier: rightCellIdentifier);
        // 注册加号cell
        collectionView.register(JCMenuAddCell.self, forCellWithReuseIdentifier: rightAddCellIdentifier);
        
        // 加载数据
        setData();
        
    }
    
    // MARK: - 加载数据
    func setData() -> Void {
        
        for index in 0..<10 {
            let model = JCMenuModel();
            model.index = index + 1;
            menuModelArray.append(model);
        }
        
        // 刷新数据
        collectionView.reloadData();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 返回行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuModelArray.count + 1;
    }
    
    // MARK: - 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rightAddCellIdentifier, for: indexPath) as? JCMenuAddCell;
            // 添加按钮的回调
            cell?.backgroundBtnCallBack = { [weak self]
                _ in
                if let addDishCallBack = self?.addDishCallBack {
                    addDishCallBack();
                }
            }
            return cell!;
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rightCellIdentifier, for: indexPath) as?JCMenuCell;
            let menuModel = menuModelArray[indexPath.row - 1];
            cell?.menuModel = menuModel;
            
            // 点击编辑，弹窗
            cell?.editBtnCallBack = { [weak self]
                (model) in
                
                if let editBtnCallBack = self?.editBtnCallBack {
                    editBtnCallBack();
                }
            }
            // 点击删除弹窗
            cell?.deleteBtnCallBack = { [weak self]
                (model) in
                
                let window = UIApplication.shared.keyWindow;
                let deleteDishView = JCDeleteDishView();
                deleteDishView.frame = (window?.bounds)!;
                window?.addSubview(deleteDishView);
                // 监听取消回调
                deleteDishView.cancelCallBack = { [weak deleteDishView]
                    _ in
                    // 移除弹窗
                    deleteDishView?.removeFromSuperview();
                }
                
                // 监听确定回调
                deleteDishView.submitCallBack = { [weak self]
                    _ in
                    guard let weakSelf = self else {
                        return;
                    }
                    // 将数据从数组中移除
                    print(model.index!);
                    print(weakSelf.menuModelArray.count);
                    weakSelf.menuModelArray.remove(at: model.index! - 1);
                    // 重新更新索引
                    for (index, tempModel) in weakSelf.menuModelArray.enumerated() {
                        tempModel.index = index + 1;
                    }
                    // 将弹窗移除
                    deleteDishView.removeFromSuperview();
                    // 刷新表格
                    let indexPath = IndexPath(item: model.index ?? 0, section: 0);
                    weakSelf.collectionView.deleteItems(at: [indexPath]);
                }
            }
            return cell!;
        }
    }
    
    // cell消失的时候刷新表格
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView.isDragging == true {
            return;
        }
        
        if collectionView.isDecelerating == true {
            return;
        }
        
        collectionView.reloadData();
    }
    

    // MARK: - 选中cell 显示编辑状态
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        // 设置背景的frame
        let backgroundX = realValue(value: 20/2);
        let backgroundY = realValue(value: 10/2);
        let backgroundW = realValue(value: 1625/2);
        let backgroundH = realValue(value: 1398/2);
        background.frame = CGRect(x: backgroundX, y: backgroundY, width: backgroundW, height: backgroundH);
        
        // 设置collectionView
        let collectionViewX = realValue(value: 0);
        let collectionViewY = realValue(value: 0);
        let collectionViewW = backgroundW - collectionViewX * CGFloat(2);
        let collectionViewH =  backgroundH - collectionViewY;
        collectionView.frame = CGRect(x: collectionViewX, y: collectionViewY, width: collectionViewW, height: collectionViewH);
        
    }

}
