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
        layout.itemSize = CGSize(width: realValue(value: 510/2), height: realValue(value: 674/2));
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
    lazy var dishlist: [JCDishModel] = [JCDishModel]();
    // 分类
    var middleModel: JCMiddleModel?;
    
    // 添加按钮的回调
    var addDishCallBack: ((_ model: JCMiddleModel) -> ())?;
    // 编辑的回调
    var editBtnCallBack: ((_ model: JCDishModel) -> ())?;
    // 删除回调
    var deleteBtnCallBack: ((_ model: JCDishModel) -> ())?;
    
    var task: URLSessionDataTask?;
    
    deinit {
        print("JCMenuView 被释放了");
        
    }
    
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
        
    }
    
    // 从服务器获取数据
    func fetchDishListFromServer(url: String, successCallBack: @escaping(_ result: [JCDishModel]) -> (), failureCallBack: @escaping(_ error: Error?) -> ()) -> Void {
       
        // 发送网络请求
        let mgr = HttpManager.shared;
        mgr.requestSerializer.timeoutInterval = 10;
        task = mgr.get(url, parameters: nil, progress: nil, success: {
            (dataTask, result) in
            
            guard let response = dataTask.response as? HTTPURLResponse else {
                return;
            }
            
            if response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 304 {
                
                
                var list = [JCDishModel]();
                if let result = result as? [[String: Any]] {
                    let _ = result.enumerated().map({
                        (dict) in
                        
                        let model = JCDishModel.modelWithDic(dict: dict.element);
                        model.DishUrl = url;
                        model.directory = self.middleModel?.MenuName;
                        model.index = dict.offset + 1;
                        list.append(model);
                    });
                    
                    successCallBack(list);
                    return;
                }
            }
            
        }, failure: {
            (dataTask, error) in
            
            failureCallBack(error);
        })
    }
    
    
    // 更新菜品列表
    func updateDishList(model: JCMiddleModel) -> Void {
        
        // 取消之前的请求
        task?.cancel();
        
        // 保存模型数据
        self.middleModel = model;
        // 清空数组
        self.dishlist.removeAll();
                
        // 添加加载视图
        let loadView = JCLoadDishListView();
        loadView.frame = bounds;
        addSubview(loadView);
        
        // 获取网络数据
        if let MenuId = model.MenuId {
            
            let url = dishlistUrl(MenuId: MenuId);
            fetchDishListFromServer(url: url, successCallBack: { (result) in
                // 清空数组
                self.dishlist.removeAll();
                // 移除加载视图
                loadView.removeFromSuperview();
                // 拼接数据
                self.dishlist += result;
                // 刷新列表
                self.collectionView.reloadData();
                
            }, failureCallBack: { (error) in
                
                // 移除加载视图
                loadView.removeFromSuperview();
                
                if let error = error {
                    print("加载菜品列表数据失败", error.localizedDescription);
                    if error.localizedDescription == "cancelled" {
                        return;
                    }
                }
                
                // 清空数组
                self.dishlist.removeAll();
                // 刷新列表
                self.collectionView.reloadData();
                
                // 添加加载失败的视图
                let loadFailure = JCLoadDishListFairuleView();
                loadFailure.frame = self.bounds;
                self.addSubview(loadFailure);
                
                loadFailure.reloadCallBack = { [weak self, weak loadFailure]
                    _ in
                    
                    // 添加加载视图
                    let loadView = JCLoadDishListView();
                    loadView.frame = (self?.bounds)!;
                    self?.addSubview(loadView);
                    
                    self?.fetchDishListFromServer(url: url, successCallBack: { (result) in
                        
                        // 清空数组
                        self?.dishlist.removeAll();
                        // 移除加载视图
                        loadView.removeFromSuperview();
                        // 移除加载失败视图
                        loadFailure?.removeFromSuperview();
                        // 拼接数据
                        self?.dishlist += result;
                        // 刷新列表
                        self?.collectionView.reloadData();
                        
                        
                    }, failureCallBack: { (error) in
                        
                        // 移除加载视图
                        loadView.removeFromSuperview();
                        
                        if let error = error {
                            print("加载菜品列表数据失败", error.localizedDescription);
                        }
                        
                        // 添加加载视图
                        let loadView = JCLoadDishListView();
                        loadView.frame = (self?.bounds)!;
                        self?.addSubview(loadView);
                        
                        delayCallBack(2, callBack: {
                            _ in
                            
                            loadView.removeFromSuperview();
                        });
                        
                    })
                }
            })
            
        } else {
            
            // 移除加载视图
            loadView.removeFromSuperview();
        }
    }
    
    // 增加菜品
    func addDish(model: JCDishModel) -> Void {
        
        // 拼接数据
        dishlist.append(model);
        
        // 重置索引
        let _ = dishlist.enumerated().map({
            (model) in
            model.element.index = model.offset + 1;
        });
        
        // 更新UI
        collectionView.reloadData();
    }
    
    // 修改菜品
    func modifityDish(model: JCDishModel) -> Void {
        
        let _ = dishlist.map({
            (temp) in
            
            if temp.DishId == model.DishId {
                temp.DishName = model.DishName;
                temp.Price = model.Price;
                temp.Thumbnail = model.Thumbnail;
                temp.PictureUrlLarge = model.PictureUrlLarge;
                temp.Detail = model.Detail;
                temp.Recommanded = model.Recommanded;
            }
        });
        
        // 更新UI
        collectionView.reloadData();
    }
    
    // 删除菜品
    func deleteDish(model: JCDishModel) -> Void {
        
        if let index = model.index {
            
            // 将要删除的数据从数组中删除
            dishlist.remove(at: index - 1);
            // 重置索引
            let _ = dishlist.enumerated().map({
                (model) in
                model.element.index = model.offset + 1;
            });
            // 删除cell
            let indexPath = IndexPath(item: index, section: 0);
            collectionView.deleteItems(at: [indexPath]);
        }
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 返回行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishlist.count + 1;
    }
    
    // MARK: - 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rightAddCellIdentifier, for: indexPath) as? JCMenuAddCell;
            // 添加按钮的回调
            cell?.backgroundBtnCallBack = { [weak self]
                _ in
                if let addDishCallBack = self?.addDishCallBack, let middleModel = self?.middleModel {
                    addDishCallBack(middleModel);
                }
            }
            return cell!;
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rightCellIdentifier, for: indexPath) as?JCMenuCell;
            let dishModel = dishlist[indexPath.row - 1];
            cell?.model = dishModel;
            // 点击编辑，弹窗
            cell?.editBtnCallBack = { [weak self]
                (model) in
                
                if let editBtnCallBack = self?.editBtnCallBack {
                    editBtnCallBack(model);
                }
            }
            
            // 点击删除弹窗
            cell?.deleteBtnCallBack = { [weak self]
                (model) in
                print("=============删除\(model.DishUrl)");
                // 删除回调
                if let deleteBtnCallBack = self?.deleteBtnCallBack {
                    deleteBtnCallBack(model);
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
