//
//  PhotoListController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import Photos


class PhotoListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    
    private let photoCellIdentifier = "photoCellIdentifier";
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: realValue(value: 396/2), height: realValue(value: 396/2));
        layout.minimumLineSpacing = realValue(value: 7/2);
        layout.minimumInteritemSpacing = realValue(value: 7/2);
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.white;
        collectionView.contentInset = UIEdgeInsets.init(top: realValue(value: 10/2), left: realValue(value: 20/2), bottom: 0, right: realValue(value: 20/2));
        return collectionView;
    }();
    
    ///取得的资源结果，用了存放的PHAsset
    var assetsFetchResults:PHFetchResult<PHAsset>!
    ///缩略图大小
    var assetGridThumbnailSize:CGSize!
    /// 带缓存的图片管理对象
    var imageManager:PHCachingImageManager!;
    private lazy var assets: [PHAsset] = [PHAsset]();
    // 存储相片
    private lazy var imageArray: [UIImage] = [UIImage]();
    // 选中图片的回调
    var selectedImageCallBack: ((_ image: UIImage) -> ())?;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置左边的返回按钮
        var image = UIImage.imageWithName(name: "album_nav_backBtn");
        image = image?.withRenderingMode(.alwaysOriginal);
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(back));
        
        // 添加collectionView
        view.addSubview(collectionView);
        
        // 注册cell
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: photoCellIdentifier);
        
        // 如果没有传入值 则获取所有资源
        if assetsFetchResults == nil {
            //则获取所有资源
            let allPhotosOptions = PHFetchOptions()
            //按照创建时间倒序排列
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                                 ascending: false)]
            //只获取图片
            allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                     PHAssetMediaType.image.rawValue)
            assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                                  options: allPhotosOptions)
            
        }
        
        
        //根据单元格的尺寸计算我们需要的缩略图大小
        let scale = UIScreen.main.scale
        let cellSize = CGSize(width: realValue(value: 396/2), height: realValue(value: 396/2));
        assetGridThumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
        
        // 采取同步获取图片（只获得一次图片）
        let options = PHImageRequestOptions();
        options.isSynchronous = true;
        options.resizeMode = .exact;
        options.isNetworkAccessAllowed = true;
        
        
        for i in 0..<assetsFetchResults.count {
            let asset = assetsFetchResults[i];
            assets.append(asset);
            if asset.mediaType != .image {
                continue;
            }
            
            // 请求图片
            PHCachingImageManager.default().requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .default, options: options, resultHandler: { [weak self]
                (image, info) in
                
                self?.imageArray.append(image!);
            })
        }

        // Do any additional setup after loading the view.
    }
 
    // 点击左边按钮返回
    func back() -> Void {
        
        let _ = self.navigationController?.popViewController(animated: true);
        
    }
    
    //重置缓存
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    
    // CollectionView行数
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults.count
    }
    
    // 获取单元格
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as? PhotoCell else {
            return PhotoCell();
        };
    
        cell.icon.image = imageArray[indexPath.row];
        
        return cell
    }
    
    // 选中cell 进入详情页面
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let photoDetail = PhotoDetailController();
        photoDetail.assets = assets;
        photoDetail.indexPath = indexPath;
        
        // 回调
        photoDetail.selectedImageCallBack = { [weak self]
            (image) in
            if let selectedImageCallBack = self?.selectedImageCallBack {
                selectedImageCallBack(image);
            }
        }
        
        self.navigationController?.pushViewController(photoDetail, animated: true);
    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        collectionView.frame = view.bounds;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("内存警告⚠️⚠️⚠️⚠️");
        // Dispose of any resources that can be recreated.
    }
}
