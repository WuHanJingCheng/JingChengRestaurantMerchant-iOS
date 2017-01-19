//
//  JCHomeController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCHomeController: UIViewController, UIAlertViewDelegate {
    
    // 顶部
    private lazy var topView: JCTopView = JCTopView();
    
    // 左侧
    private lazy var leftVc: JCLeftController = JCLeftController();
    
    // 中间子菜单
    private lazy var middleVc: JCMiddleController = JCMiddleController();
    
    // 右边视图
    private lazy var rightVc: JCRightController = JCRightController();
    
    // 保存删除数据模型
    var deleteModel: JCDishModel?;
    
    // 移除通知
    deinit {
        print("JCHomeController 被释放了");
    }
    
    // 显示状态栏为lightContent
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        // 添加顶部视图
        view.addSubview(topView);
        
        // 添加左侧视图
        view.addSubview(leftVc.view);
        addChildViewController(leftVc);
        
        // 添加中间子菜单
        view.addSubview(middleVc.view);
        addChildViewController(middleVc);
        
 
        // 添加右边视图
        view.addSubview(rightVc.view);
        addChildViewController(rightVc);
        
        
        // 将左边的值，传给子菜单
        leftVc.sendLeftModelCallBack = { [weak self]
            (menuName) in
           
            switch menuName {
            case "我的":
                // 我的
                let mineView = JCMineView();
                mineView.frame = (self?.view.bounds)!;
                self?.view.addSubview(mineView);
                // 添加动画
                ZXAnimation.startAnimation(targetView: mineView);
                
                
                // 消失的回调
                mineView.deleteBtnCallBack = {
                    _ in
                    // 添加消失动画
                    ZXAnimation.stopAnimation(targetView: mineView, completion: nil);
                }
                
                // 退出的回调
                mineView.quiteBtnCallBack = { [weak self]
                    _ in
                    // 让控制器消失
                    self?.dismiss(animated: true, completion: nil);
                }
                
            case "菜单":
                // 菜单
                self?.rightVc.menuView.isHidden = false;
                self?.rightVc.orderView.isHidden = true;
                self?.middleVc.menuName = menuName;
                
            default:
                // 订单
                self?.rightVc.menuView.isHidden = true;
                self?.rightVc.orderView.isHidden = false;
                self?.middleVc.menuName = menuName;
                self?.rightVc.orderView.recordView.isHidden = true;
                self?.rightVc.orderView.orderLeftView.isHidden = false;
                // 发送通知
                NotificationCenter.default.post(name: ChangePaidBtnStatusNotification, object: nil, userInfo: ["ChangePaidBtnStatusNotification": "结账"]);
            }
        }
        
        // 添加分类
        middleVc.addBtnCallBack = { [weak self]
            (menulist) in
            
            // 添加弹窗
            let subMenuListVc = JCSubMenuListController();
            subMenuListVc.submenus = menulist;
            subMenuListVc.modalTransitionStyle = .crossDissolve;
            self?.present(subMenuListVc, animated: true, completion: nil);
            
            // 删除子菜单
            subMenuListVc.deleteSubMenuCallBack = { [weak self]
                (model) in
                self?.middleVc.deleteSubMenu(model: model);
            }
            
        }
        
        // 菜单回调
        middleVc.subMenuCallBack = { [weak self]
            (model) in
            
            // 请求数据
            self?.rightVc.updateDishList(model: model);
        }
        
        // 订单分类回调
        middleVc.orderCallBack = { [weak self]
            (model) in
            
            if model.MenuName == "记录" {
                
                // 隐藏订单卓号界面
                self?.rightVc.orderView.orderLeftView.isHidden = true;
                // 显示订单记录页面
                self?.rightVc.orderView.recordView.isHidden = false;
                
                // 隐藏空闲和停用页面
                self?.rightVc.orderView.forbidView.isHidden = true;
                // 显示订单详情页面
                self?.rightVc.orderView.orderDetailView.isHidden = false;
                
                // 发送通知
                NotificationCenter.default.post(name: ChangePaidBtnStatusNotification, object: nil, userInfo: ["ChangePaidBtnStatusNotification": "已结账"]);
                
                return;
            }
            
            // 显示订单卓号界面
            self?.rightVc.orderView.orderLeftView.isHidden = false;
            // 隐藏订单记录页面
            self?.rightVc.orderView.recordView.isHidden = true;
            
            
            // 处理订单交互
            let _ = self?.rightVc.orderView.orderLeftView.orderModelArray.enumerated().map({
                (element) in
                
                if element.element.isSelected == true {
                    if element.element.tag == 0 {
                        // 隐藏空闲和停用页面
                        self?.rightVc.orderView.forbidView.isHidden = true;
                        // 显示订单详情页面
                        self?.rightVc.orderView.orderDetailView.isHidden = false;
                    } else {
                        
                        // 隐藏空闲和停用页面
                        self?.rightVc.orderView.forbidView.isHidden = false;
                        // 显示订单详情页面
                        self?.rightVc.orderView.orderDetailView.isHidden = true;
                    }
                }
            });
            
            // 发送通知
            NotificationCenter.default.post(name: ChangePaidBtnStatusNotification, object: nil, userInfo: ["ChangePaidBtnStatusNotification": "结账"]);
        }

        
        // 添加菜的回调
        rightVc.addDishCallBack = { [weak self]
            (middleModel) in
            let dishDetail = JCDishDetailController();
            dishDetail.titleView.text = "添加菜品";
            dishDetail.view.frame = (self?.view.bounds)!;
            dishDetail.middleModel = middleModel
            self?.view.addSubview(dishDetail.view);
            self?.addChildViewController(dishDetail);
            
            ZXAnimation.startAnimation(targetView: dishDetail.view);
            
            // 取消按钮的回调
            dishDetail.cancelCallBack = { [weak dishDetail]
                _ in
                ZXAnimation.stopAnimation(targetView: (dishDetail?.view)!, completion: { [weak dishDetail]
                    _ in
                    
                    dishDetail?.removeFromParentViewController();
                });
            }
            
            // 确定按钮的回调
            dishDetail.submitCallBack = { [weak dishDetail]
                (model) in
                
                // 移除窗口
                ZXAnimation.stopAnimation(targetView: (dishDetail?.view)!, completion: { [weak dishDetail]
                    _ in
                    
                    dishDetail?.removeFromParentViewController();
                })
                
                // 添加上传视图
                let uploadpoppuView = JCUpLoadPopupView();
                uploadpoppuView.frame = (self?.view.bounds)!;
                self?.view.addSubview(uploadpoppuView);
                // 添加加载视图
                ZXAnimation.startAnimation(targetView: uploadpoppuView);
                // 正在上传
                uploadpoppuView.loadingImage();
                
                guard let directory = model.directory else {
                    print("菜品目录不能为空");
                    // 上传失败
                    uploadpoppuView.uploadFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                guard let DishName = model.DishName else {
                    print("菜名不能为空");
                    // 上传失败
                    uploadpoppuView.uploadFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                guard let imageData = model.imageData else {
                    print("缩略图不能为空");
                    // 上传失败
                    uploadpoppuView.uploadFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                guard let largeImageData = model.largeImageData else {
                    print("大图不能为空");
                    // 上传失败
                    uploadpoppuView.uploadFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                // 上传图片
                BlobManager.shared.uploadSmallImageAndLargeImageToBlob(directory: directory, blobName: DishName, smallImageData: imageData, largeImageData: largeImageData, completionHandler: { (containerError, smallError, smallBlob, largeError, largeBlob) in
                    
                    if let containerError = containerError {
                        print("创建容器失败", containerError.localizedDescription);
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    }
                    
                    if let smallError = smallError {
                        print("菜品缩略图上传失败", smallError.localizedDescription);
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    } else {
                        
                        print("菜品缩略图上传成功");
                        
                        // 获取图片URL
                        if let smallBlob = smallBlob {
                            
                            model.Thumbnail = smallBlob.storageUri.primaryUri.absoluteString;
                            
                        }
                    }
                    
                    
                    if let largeError = largeError {
                        print("菜品大图上传失败", largeError.localizedDescription);
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    } else {
                        
                        print("菜品大图上传成功");
                        
                        if let largeBlob = largeBlob {
                            model.PictureUrlLarge = largeBlob.storageUri.primaryUri.absoluteString;
                        }
                    }
                    // 上传JSON数据
                    let parameters: [String: Any] = ["DishName": model.DishName ?? "", "Thumbnail": model.Thumbnail ?? "", "PictureUrlLarge": model.PictureUrlLarge ?? "", "Price": model.Price ?? 0.0, "Detail": model.Detail ?? "", "Recommanded": model.Recommanded ?? false];
                    
                    guard let MenuId = middleModel.MenuId else {
                        return;
                    }
                    
                    let url = dishlistUrl(MenuId: MenuId);
                    
                    HttpManager.shared.uploadSubMenuList(url: url, parameters: parameters, succussCallBack: { (data, response) in
                        
                        // 上传成功
                        uploadpoppuView.uploadSuccess();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                            // 获取上传的数据
                            if let data = data {
                                guard let dict = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                                    return;
                                }
                                
                                let dishModel = JCDishModel.modelWithDic(dict: dict);
                                self?.rightVc.addDish(model: dishModel);
                                print("上传菜品JSON数据成功");
                            }
                            
                        })
                        
                        
                    }, failureCallBack: { (error) in
                        
                        print("上传菜品JSON数据失败");
                        // 上传失败
                        uploadpoppuView.uploadFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                        })
                        
                        if let error = error {
                            print(error.localizedDescription);
                        }
                    })
                })
            }
        }
        
        
        // 修改菜品
        rightVc.editBtnCallBack = { [weak self]
            (model) in
            
            let dishDetail = JCDishDetailController();
            dishDetail.titleView.text = "修改菜品信息";
            dishDetail.middleModel = self?.rightVc.menuView.middleModel;
            dishDetail.model = model;
            dishDetail.view.frame = (self?.view.bounds)!;
            self?.view.addSubview(dishDetail.view);
            self?.addChildViewController(dishDetail);
            ZXAnimation.startAnimation(targetView: dishDetail.view);
            
            // 显示菜品信息
            dishDetail.showDishInfo(model: model);
            
            
            // 取消按钮的回调
            dishDetail.cancelCallBack = { [weak dishDetail]
                _ in
                ZXAnimation.stopAnimation(targetView: (dishDetail?.view)!, completion: { [weak dishDetail]
                    _ in
                    dishDetail?.removeFromParentViewController();
                });
            }
            
            // 确认按钮的回调
            dishDetail.submitCallBack = { [weak dishDetail]
                (dishDetailModel) in
                // 移除窗口
                ZXAnimation.stopAnimation(targetView: (dishDetail?.view)!, completion: {  [weak dishDetail]
                    _ in
                    dishDetail?.removeFromParentViewController();
                })
                
                // 显示加载视图
                let uploadpoppuView = JCUpLoadPopupView();
                uploadpoppuView.frame = (self?.view.bounds)!;
                self?.view.addSubview(uploadpoppuView);
                // 添加加载视图
                ZXAnimation.startAnimation(targetView: uploadpoppuView);
                // 正在修改
                uploadpoppuView.modifitingImage();
                
                guard let directory = dishDetailModel.directory else {
                    
                    debugPrint("目录不能为空");
                    uploadpoppuView.modifityFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                guard let blobName = dishDetailModel.DishName else {
                    
                    debugPrint("文件名不能为空");
                    // 修改失败
                    uploadpoppuView.modifityFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                guard let smallImageData = dishDetailModel.imageData else {
                    debugPrint("缩略图不能为空");
                    // 修改失败
                    uploadpoppuView.modifityFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                guard let largeImageData = dishDetailModel.largeImageData else {
                    debugPrint("大图不能为空");
                    // 修改失败
                    uploadpoppuView.modifityFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    })
                    return;
                }
                
                
                // 更新远程图片
                BlobManager.shared.uploadSmallImageAndLargeImageToBlob(directory: directory, blobName: blobName, smallImageData: smallImageData, largeImageData: largeImageData, completionHandler: { (containerError, smallError, smallBlob, largeError, largeBlob) in
                    
                    if let containerError = containerError {
                        print("创建容器失败", containerError.localizedDescription);
                        uploadpoppuView.modifityFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    }
                    
                    if let smallError = smallError {
                        print("上传缩略图失败", smallError);
                        uploadpoppuView.modifityFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    } else {
                        dishDetailModel.Thumbnail = smallBlob?.storageUri.primaryUri.absoluteString;
                    }
                    
                    if let largeError = largeError {
                        print("上传大图失败", largeError);
                        uploadpoppuView.modifityFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        })
                        return;
                    } else {
                        // 获取大图上传成功后的URL
                        if let largeBlob = largeBlob {
                            dishDetailModel.PictureUrlLarge = largeBlob.storageUri.primaryUri.absoluteString;
                        }
                    }
                    // 参数
                    var parameters = [String: Any]();
                    
                    if let Thumbnail = dishDetailModel.Thumbnail {
                        parameters["Thumbnail"] = Thumbnail;
                    }
                    
                    if let DishName = dishDetailModel.DishName {
                        parameters["DishName"] = DishName;
                    }
                    
                    if let Price = dishDetailModel.Price {
                        parameters["Price"] = Price;
                    }
                    
                    if let Recommanded = dishDetailModel.Recommanded {
                        parameters["Recommanded"] = Recommanded;
                    }
                    
                    if let Detail = dishDetailModel.Detail {
                        parameters["Detail"] = Detail;
                    }
                    
                    if let PictureUrlLarge = dishDetailModel.PictureUrlLarge {
                        parameters["PictureUrlLarge"] = PictureUrlLarge;
                    }
                    
                    if let DishId = dishDetailModel.DishId {
                        
                        HttpManager.shared.modifityServerData(url: modifityDishUrl(DishId: DishId), parameters: parameters, succussCallBack: { (data, response) in
                            
                            uploadpoppuView.modifitySuccess();
                            // 移除窗口
                            delayCallBack(1, callBack: { () -> () in
                                ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                                // 更新菜品信息
                                if let data = data {
                                    guard let dict = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                                        return;
                                    }
                                    
                                    let dishModel = JCDishModel.modelWithDic(dict: dict);
                                    self?.rightVc.modifityDish(model: dishModel);
                                    // 修改菜品JSON数据成功
                                    print("修改菜品JSON数据成功");
                                }
                                
                            })
                            
                        }, failureCallBack: { (error) in
                            
                            uploadpoppuView.modifityFailure();
                            // 移除窗口
                            delayCallBack(1, callBack: { () -> () in
                                ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                                // 修改菜品JSON数据失败
                                print("修改菜品JSON数据失败");
                            })
                            
                            if let error = error {
                                print(error);
                            }
                        })
                    } else {
                        
                        uploadpoppuView.modifityFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            // 修改菜品JSON数据失败
                            print("修改菜品JSON数据失败");
                        })
                    }
                })
            }
        }
        
        
        // 菜品删除回调
        rightVc.deleteBtnCallBack = { [weak self]
            (model) in
            
            self?.deleteModel = model;
            print("++++++++++删除\(model.DishUrl)");
            // 添加弹窗
            let alertView = UIAlertView.init(title: "确认删除该菜品吗？", message: "删除后将无法恢复！", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定");
            alertView.show();
        }
 
    }
    
    // 弹窗
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 0 {
            // 取消
            
        } else {
            
            // 显示加载视图
            let uploadpoppuView = JCUpLoadPopupView();
            uploadpoppuView.frame = self.view.bounds;
            self.view.addSubview(uploadpoppuView);
            // 添加加载视图
            ZXAnimation.startAnimation(targetView: uploadpoppuView);
            // 正在删除
            uploadpoppuView.deletingImage();
            
            // 确认
            if let deleteModel = self.deleteModel {
                
                // 删除远程数据
                if let DishId = deleteModel.DishId {
                    
                    let url = deleteDishUrl(DishId: DishId);
                    print(url);
                    HttpManager.shared.deleteServerData(url: url, succussCallBack: { (data) in
                        
                        // 删除成功
                        uploadpoppuView.deleteSuccess();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                            // 删除菜品
                            self.rightVc.deleteDish(model: deleteModel);
                            
                            // 删除成功
                            print("删除成功");
                        })
                        
                        
                    }, failureCallBack: { (error) in
                        
                        
                        // 删除失败
                        uploadpoppuView.deleteFailure();
                        // 移除窗口
                        delayCallBack(1, callBack: { () -> () in
                            
                            ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                            
                            // 删除失败
                            print("删除失败");
                        })
                        
                        if let error = error {
                            print(error.localizedDescription);
                        }
                    })
                    
                } else {
                    
                    // 删除失败
                    uploadpoppuView.deleteFailure();
                    // 移除窗口
                    delayCallBack(1, callBack: { () -> () in
                        
                        ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                        
                    })
                }
            } else {
                
                // 删除失败
                uploadpoppuView.deleteFailure();
                // 移除窗口
                delayCallBack(1, callBack: { () -> () in
                    
                    ZXAnimation.stopAnimation(targetView: uploadpoppuView, completion: nil);
                    
                })
            }
        }
    }
    
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置顶部
        let topViewX = CGFloat(0);
        let topViewY = CGFloat(40/2);
        let topViewW = width;
        let topViewH = CGFloat(88/2);
        topView.frame = CGRect(x: topViewX, y: topViewY, width: topViewW, height: topViewH);
        
        // 设置左侧视图
        let leftVcX = realValue(value: 0);
        let leftVcY = topView.frame.maxY;
        let leftVcW = realValue(value: 192/2);
        let leftVcH = height - leftVcY;
        leftVc.view.frame = CGRect(x: leftVcX, y: leftVcY, width: leftVcW, height: leftVcH);
        
        // 设置中间视图的frame
        let middleVcX = leftVc.view.frame.maxX;
        let middleVcY = leftVcY;
        let middleVcW = leftVcW;
        let middleVcH = leftVcH;
        middleVc.view.frame = CGRect(x: middleVcX, y: middleVcY, width: middleVcW, height: middleVcH);
        
        // 设置右侧视图的frame
        let rightVcX = middleVc.view.frame.maxX;
        let rightVcY = leftVcY;
        let rightVcW = width - middleVcX;
        let rightVcH = leftVcH;
        rightVc.view.frame = CGRect(x: rightVcX, y: rightVcY, width: rightVcW, height: rightVcH);
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
