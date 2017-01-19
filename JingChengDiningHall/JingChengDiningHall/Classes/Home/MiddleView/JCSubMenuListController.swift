//
//  JCSubMenuListController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/3.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCSubMenuListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate {
    
    private let submenuListCellID = "submenuListCellID";
    private let submenulistAddCellID = "submenulistAddCellID";
    
    // 顶部
    private lazy var topView: JCSubMenuTopView = JCSubMenuTopView();
    
    // 表格
    private lazy var collectionView: UICollectionView = {
        let layout = ZXCollectionViewLayout();
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.clear;
        return collectionView;
    }();
    
    // 数组
    var submenus: [JCMiddleModel]?;
    
    // 保存即将要删除的数据
    var currentModel: JCMiddleModel?;
    // 更新上一级页面
    var deleteSubMenuCallBack: ((_ model: JCMiddleModel) -> ())?;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加顶部视图
        view.addSubview(topView);
        
        // 添加表格
        view.addSubview(collectionView);
        
        // 注册cell
        collectionView.register(JCSubMenuListCell.self, forCellWithReuseIdentifier: submenuListCellID);
        // 注册加号cell
        collectionView.register(JCSubMenuListAddCell.self, forCellWithReuseIdentifier: submenulistAddCellID);
        
        // 返回按钮的点击回调
        topView.backBtnCallBack = { [weak self]
            _ in
            self?.dismiss(animated: true, completion: nil);
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    // 返回行
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let submenus = submenus {
            return submenus.count + 1;
        } else {
            return 1;
        }
        
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == submenus?.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: submenulistAddCellID, for: indexPath) as? JCSubMenuListAddCell;
            return cell!;
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: submenuListCellID, for: indexPath) as? JCSubMenuListCell;
            if let submenus = self.submenus, indexPath.row < submenus.count {
                let model = submenus[indexPath.row];
                model.index = indexPath.row;
                cell?.model = model;
                // 删除回调
                cell?.deleteCallBack = { [weak self]
                    (currentModel) in
                    self?.currentModel = currentModel;
                    // 弹窗
                    let alertView = UIAlertView.init(title: "确定删除此类别", message: "会同时删除菜品", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定");
                    alertView.show();
                }
            }
            
            return cell!;
        }
    }
    
    // 弹窗
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        if buttonIndex == 0 {
            
            print("点击了取消按钮");
        } else {
            
            // 显示加载视图
            let uploadpoppuView = JCUpLoadPopupView();
            uploadpoppuView.frame = self.view.bounds;
            self.view.addSubview(uploadpoppuView);
            // 添加加载视图
            ZXAnimation.startAnimation(targetView: uploadpoppuView);
            // 正在删除
            uploadpoppuView.deletingImage();
            print("**********\(currentModel?.index),    \(currentModel?.MenuId)");
            if let currentModel = self.currentModel, let index = currentModel.index {
                
                // 发送请求，删除远程数据
                if let MenuId = currentModel.MenuId {
                   
                    HttpManager.shared.deleteServerData(url: deleteSubMenuURL(menuId: MenuId), succussCallBack: { (data) in
                        
                        // 删除成功
                        print("删除成功");
                        // 删除成功
                        uploadpoppuView.deleteSuccess();
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                            // 删除元素
                            self.submenus?.remove(at: index);
                            // 更新索引
                            let _ = self.submenus?.enumerated().map({
                                (submenu) in
                                submenu.element.index = submenu.offset;
                            });
                            // 删除cell
                            let indexPath = IndexPath(row: index, section: 0);
                            self.collectionView.deleteItems(at: [indexPath]);
                            
                            // 更新上一级UI
                            if let deleteSubMenuCallBack = self.deleteSubMenuCallBack {
                                deleteSubMenuCallBack(currentModel);
                            }
                        })
                        
                    }, failureCallBack: { (error) in
                        
                        print("删除失败");
                        // 删除失败
                        uploadpoppuView.deleteFailure();
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                        })
                        
                        if let error = error {
                            print(error.localizedDescription);
                        }
                    })
                    
                } else {
                    
                    // 删除失败
                    uploadpoppuView.deleteFailure();
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        
                    })
                }
            } else {
                
                // 删除失败
                uploadpoppuView.deleteFailure();
                delayCallBack(1, callBack: { () -> () in
                    
                    ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    
                })
            }
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
    
    // 选中cell，弹窗
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 修改子菜单
        if let submenus = self.submenus, indexPath.row < submenus.count {
            
            // 添加弹框
            let addSubMenuVc = JCAddSubMenuController();
            addSubMenuVc.view.frame = self.view.bounds;
            self.view.addSubview(addSubMenuVc.view);
            self.addChildViewController(addSubMenuVc);
            ZXAnimation.startAnimation(targetView: addSubMenuVc.view);
            
            // 展示子菜单信息
            let model = submenus[indexPath.row];
            addSubMenuVc.showSubMenuInfo(model: model);
            
            // 点击取消按钮隐藏
            addSubMenuVc.cancelBtnCallBack = { [weak addSubMenuVc]
                _ in
                // 移除弹窗
                ZXAnimation.stopAnimation(targetView: (addSubMenuVc?.view)!, completion: { [weak addSubMenuVc]
                    _ in
                    
                    addSubMenuVc?.removeFromParentViewController();
                });
            }
            
            // 点击确定按钮，保存修改信息
            addSubMenuVc.submitBtnCallBack = { [weak addSubMenuVc]
                (model) in
                
                // 移除弹窗
                ZXAnimation.stopAnimation(targetView: (addSubMenuVc?.view)!, completion: { [weak addSubMenuVc]
                    _ in
                    addSubMenuVc?.removeFromParentViewController();
                })
                
                // 显示加载视图
                let uploadpoppuView = JCUpLoadPopupView();
                uploadpoppuView.frame = self.view.bounds;
                self.view.addSubview(uploadpoppuView);
                // 添加加载视图
                ZXAnimation.startAnimation(targetView: uploadpoppuView);
                // 正在修改
                uploadpoppuView.modifitingImage();
               
                guard let blobName = model.MenuName else {
                    // 修改失败
                    uploadpoppuView.modifityFailure();
                    // 移除加载视图
                    delayCallBack(1, callBack: {
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                // 上传子菜单图标
                BlobManager.shared.uploadMoreBlobsToContainer(blobName: blobName, imageData_normal: model.image_normal_data, imageData_selected: model.image_selected_data, completionHandler: { (containerError, normalError, normalBlob, selectedError, selectedBlob) in
                    
                    if let containerError = containerError {
                        print("创建容器失败", containerError.localizedDescription);
                        // 修改失败
                        uploadpoppuView.modifityFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    }
                    
                    if let normalError = normalError {
                        print("上传普通状态的图片失败", normalError);
                        // 修改失败
                        uploadpoppuView.modifityFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    } else {
                        
                        if let normalBlob = normalBlob {
                            model.PictureUrl = normalBlob.storageUri.primaryUri.absoluteString;
                        } else {
                            // 说明没有修改普通状态的图片
                            let currentModel = submenus[indexPath.row];
                            model.PictureUrl = currentModel.PictureUrl;
                        }
                        
                    }
                    
                    if let selectedError = selectedError {
                        print("上传选中状态的图片失败", selectedError);
                        // 修改失败
                        uploadpoppuView.modifityFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        });
                        return;
                    } else {
                        
                        if let selectedBlob = selectedBlob {
                            model.PictureUrlSelected = selectedBlob.storageUri.primaryUri.absoluteString;
                        } else {
                            // 说明修改选中状态的图片
                            let currentModel = submenus[indexPath.row];
                            model.PictureUrlSelected = currentModel.PictureUrlSelected;
                        }
                    }
                    
                    print("上传菜品分类图标成功");
                    
                    var parameters = [String: Any]();
                    // 普通状态图片的url
                    if let PictureUrl = model.PictureUrl {
                        parameters["PictureUrl"] = PictureUrl;
                    }
                    // 选中状态图片的url
                    if let PictureUrlSelected = model.PictureUrlSelected {
                        parameters["PictureUrlSelected"] = PictureUrlSelected;
                    }
                    // 目录
                    if let MenuName = model.MenuName {
                        parameters["MenuName"] = MenuName;
                    }
                    
                    // menuId
                    let currentModel = submenus[indexPath.row];
                    model.MenuId = currentModel.MenuId;
                    
                    // 修改
                    if let MenuId = model.MenuId {
                        
                        parameters["MenuId"] = MenuId;
                        print(parameters);
                        HttpManager.shared.modifityServerData(url: submenuURL(restaurantId: restaurantId), parameters: parameters, succussCallBack: { (data, response) in
                            
                            print("修改子菜单成功");
                            // 修改成功
                            uploadpoppuView.modifitySuccess();
                            // 移除加载视图
                            delayCallBack(1, callBack: { () -> () in
                                
                                ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                                
                                // 更新数据源
                                // 删除旧模型数据
                                self.submenus?.remove(at: indexPath.row);
                                // 插入新的模型数据
                                self.submenus?.insert(model, at: indexPath.row);
                                
                                // 更新索引
                                let _ = self.submenus?.enumerated().map({
                                    (submenu) in
                                    submenu.element.index = submenu.offset;
                                });
                                
                                // 更新UI
                                self.collectionView.reloadData();
                                
                            })
                            
                            
                            if let data = data {
                                print(data);
                            }
                            
                            if let response = response {
                                debugPrint(response);
                            }
                            
                        }, failureCallBack: { (error) in
                            
                            print("修改子菜单失败");
                            // 修改失败
                            uploadpoppuView.modifityFailure();
                            // 移除加载视图
                            delayCallBack(1, callBack: {
                                
                                ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                                
                            });
                            
                            if let error = error {
                                print(error.localizedDescription);
                            }
                        })
                        
                    } else {
                        
                        // 修改失败
                        uploadpoppuView.modifityFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                    }
                })
            }
        }
        // 添加子菜单
        else {
            
            // 添加弹框
            let addSubMenuVc = JCAddSubMenuController();
            addSubMenuVc.view.frame = self.view.bounds;
            self.view.addSubview(addSubMenuVc.view);
            self.addChildViewController(addSubMenuVc);
            ZXAnimation.startAnimation(targetView: addSubMenuVc.view);
            
            // 点击取消按钮隐藏
            addSubMenuVc.cancelBtnCallBack = { [weak addSubMenuVc]
                _ in
                // 移除弹窗
                ZXAnimation.stopAnimation(targetView: (addSubMenuVc?.view)!, completion: { [weak addSubMenuVc]
                    _ in
                    
                    addSubMenuVc?.removeFromParentViewController();
                });
            }
            
            // 点击确定按钮，保存修改信息
            addSubMenuVc.submitBtnCallBack = { [weak addSubMenuVc]
                (model) in
                
                // 移除弹窗
                ZXAnimation.stopAnimation(targetView: (addSubMenuVc?.view)!, completion: { [weak addSubMenuVc]
                    _ in
                    addSubMenuVc?.removeFromParentViewController();
                })
                
                // 显示加载视图
                let uploadpoppuView = JCUpLoadPopupView();
                uploadpoppuView.frame = self.view.bounds;
                self.view.addSubview(uploadpoppuView);
                // 添加加载视图
                ZXAnimation.startAnimation(targetView: uploadpoppuView);
                // 正在上传
                uploadpoppuView.loadingImage();
                
                // 上传图片
                guard let blobName = model.MenuName else {
                    print("分类目录名称不能为空");
                    return;
                }
                
                
                // 上传子菜单图标
                BlobManager.shared.uploadMoreBlobsToContainer(blobName: blobName, imageData_normal: model.image_normal_data, imageData_selected: model.image_selected_data, completionHandler: { (containerError, normalError, normalBlob, selectedError, selectedBlob) in
                    
                    
                    if let containerError = containerError {
                        print("创建容器失败，或容器已存在", containerError.localizedDescription);
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    }
                    
                    if let normalError = normalError {
                        print("上传普通状态的图片失败", normalError);
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    } else {
                        model.PictureUrl = normalBlob?.storageUri.primaryUri.absoluteString;
                    }
                    
                    if let selectedError = selectedError {
                        print("上传选中状态的图片失败", selectedError);
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        });
                        return;
                    } else {
                        model.PictureUrlSelected = selectedBlob?.storageUri.primaryUri.absoluteString;
                    }
                    
                    print("上传菜品分类图标成功");
                    
                    guard let PictureUrl = model.PictureUrl else {
                        print("普通状态的图片不能为空");
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    }
                    
                    guard let PictureUrlSelected = model.PictureUrlSelected else {
                        print("选中状态的图片不能为空");
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    }
                    
                    guard let MenuName = model.MenuName else {
                        print("菜品分类名不能为空");
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    }
                    
                   
                    // 上传子菜单JSON数据
                    let parameters = ["PictureUrl": PictureUrl, "PictureUrlSelected": PictureUrlSelected, "MenuName": MenuName];
                    
                    HttpManager.shared.uploadSubMenuList(url: submenulistUrl(restaurantId: restaurantId), parameters: parameters, succussCallBack: { (data, response) in
                        
                        print("上传子菜单JSON数据成功");
                        // 上传成功
                        uploadpoppuView.uploadSuccess();
                        // 移除加载视图
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                            if let data = data {
                                guard let dict = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                                    return;
                                }
                                
                                let middleModel = JCMiddleModel.modelWidthDict(dict: dict);
                                // 拼接数据
                                self.submenus?.append(middleModel);
                                // 更新索引
                                let _ = self.submenus?.enumerated().map({
                                    (submenu) in
                                    submenu.element.index = submenu.offset;
                                });
                                // 刷新表格
                                self.collectionView.reloadData();
                                
                                // 发送通知，刷新分类列表
                                if let submenus = self.submenus {
                                    
                                    NotificationCenter.default.post(name: ReloadMenuListNotification, object: nil, userInfo: ["ReloadMenuListNotification": submenus]);
                                }
                            }
                        })
                        
                    }, failureCallBack: { (error) in
                        
                        print("上传JSON数据失败");
                        
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除加载视图
                        delayCallBack(1, callBack: {
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                        });
                        
                        if let error = error {
                            print(error.localizedDescription);
                        }
                    })
                })
            }
        }
    }
    

    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置topView 的frame
        let topViewX = realValue(value: 0);
        let topViewY = realValue(value: 40/2);
        let topViewW = width;
        let topViewH = realValue(value: 88/2);
        topView.frame = CGRect(x: topViewX, y: topViewY, width: topViewW, height: topViewH);
        
        
        // 设置collectionView的frame 
        let collectionViewX = realValue(value: 21.5/2);
        let collectionViewY = topView.frame.maxY + realValue(value: 20/2);
        let collectionViewW = width - collectionViewX * CGFloat(2);
        let collectionViewH = height - collectionViewY;
        collectionView.frame = CGRect(x: collectionViewX, y: collectionViewY, width: collectionViewW, height: collectionViewH);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
