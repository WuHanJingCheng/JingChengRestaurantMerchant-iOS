//
//  AlbumListController.swift
//  自定义UIImagePickerController
//
//  Created by zhangxu on 2016/12/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import Photos


//相簿列表项
class AlbumItem {
    //相簿名称
    var title:String?
    //相簿内的资源
    var fetchResult:PHFetchResult<PHAsset>
    
    init(title:String?,fetchResult:PHFetchResult<AnyObject>){
        self.title = title
        self.fetchResult = fetchResult as! PHFetchResult<PHAsset>
    }
}

class AlbumListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //相簿列表项集合
    var items:[AlbumItem] = []
    
    private lazy var tableView: UITableView = {
        let tablView = UITableView.init(frame: .zero, style: .plain);
        tablView.dataSource = self;
        tablView.delegate = self;
        tablView.backgroundColor = UIColor.clear;
        tablView.rowHeight = CGFloat(178/2);
        tablView.tableFooterView = UIView();
        return tablView;
    }();
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
    // 图片的回调
    var selectedImageCallBack: ((_ image: UIImage) -> ())?;
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white;
        // 设置左边的返回按钮
        var image = UIImage.imageWithName(name: "album_nav_backBtn");
        image = image?.withRenderingMode(.alwaysOriginal);
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(back));
        
        // 添加tableView
        view.addSubview(tableView);
        
        // 设置相册访问权限
        // 判断用户状态，未给予授权
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            
            // 授权请求访问相册
            PHPhotoLibrary.requestAuthorization({ (status) in
                
                // 获取授权状态
                switch status {
                case .denied:
                    print("拒绝访问");
                    return;
                default:
                    break;
                }
                
                print("status\(status)");
                
            })
        }
        
        // 列出所有系统的智能相册
        let smartOptions = PHFetchOptions()
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum,
                                                                          subtype: PHAssetCollectionSubtype.albumRegular,
                                                                          options: smartOptions)
        self.convertCollection(collection: smartAlbums as! PHFetchResult<AnyObject>)
        
        //列出所有用户创建的相册
        let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        self.convertCollection(collection: userCollections as! PHFetchResult<AnyObject>)
        
        //相册按包含的照片数量排序（降序）
        self.items.sort { (item1, item2) -> Bool in
            return item1.fetchResult.count > item2.fetchResult.count
        }
        
        // 将相册名改为中文
        let _ = items.map({
            (item) in
            if item.title == "Slo-mo" {
                item.title = "慢动作";
            } else if item.title == "Recently Added" {
                item.title = "最近添加";
            } else if item.title == "Favorites" {
                item.title = "个人收藏";
            } else if item.title == "Recently Deleted" {
                item.title = "最近删除";
            } else if item.title == "Videos" {
                item.title = "视频";
            } else if item.title == "All Photos" {
                item.title = "所有照片";
            } else if item.title == "Selfies" {
                item.title = "自拍";
            } else if item.title == "Screenshots" {
                item.title = "屏幕快照";
            } else if item.title == "Camera Roll" {
                item.title = "相机胶卷";
            }
        });
      
        
        // 注册cell
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell");
    }
    
    //转化处理获取到的相簿
    private func convertCollection(collection:PHFetchResult<AnyObject>){
        
        for i in 0..<collection.count{
            //获取出但前相簿内的图片
            let resultsOptions = PHFetchOptions()
            resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                               ascending: false)]
            resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                   PHAssetMediaType.image.rawValue)
            guard let c = collection[i] as? PHAssetCollection else { return }
            let assetsFetchResult = PHAsset.fetchAssets(in: c ,
                                                                         options: resultsOptions)
            //没有图片的空相簿不显示
            if assetsFetchResult.count > 0{
                items.append(AlbumItem(title: c.localizedTitle, fetchResult: assetsFetchResult as! PHFetchResult<AnyObject>))
            }
        }
        
    }
    
    // 点击左边按钮返回
    func back() -> Void {
        
        dismiss(animated: true, completion: nil);
    }
    
    // 返回表尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1;
    }
    
    //表格分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

   
    
    //表格单元格数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }

    
    //设置单元格内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "AlbumCell"
        //同一形式的单元格重复使用，在声明时已注册
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as? AlbumCell else {
            return AlbumCell();
        }
        let item = self.items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.countLabel.text = "(\(item.fetchResult.count))"
        return cell
    }
    
    // 选中cell跳转至图片列表
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let photoListVc = PhotoListController();
    
        // 选中图片的回调
        photoListVc.selectedImageCallBack = { [weak self]
            (image) in
            
            if let selectedImageCallBack = self?.selectedImageCallBack {
                selectedImageCallBack(image);
                // 消失
                self?.dismiss(animated: true, completion: nil);
            }
        }
        //获取选中的相簿信息
        let item = self.items[indexPath.row]
        //设置标题
        photoListVc.title = item.title;
        //传递相簿内的图片资源
        photoListVc.assetsFetchResults = item.fetchResult
        // 跳转
        self.navigationController?.pushViewController(photoListVc, animated: true);
        
    }
    
    
    // 设置tableView 的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        tableView.frame = view.bounds;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
