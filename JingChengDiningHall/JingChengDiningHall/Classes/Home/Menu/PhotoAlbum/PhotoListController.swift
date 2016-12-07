//
//  PhotoListController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import Photos

protocol DissmissAlbumListDelegate: NSObjectProtocol {
    func dismissAlubmList(_ image: UIImage) -> Void
}

class PhotoListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: DissmissAlbumListDelegate?;
    
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
    var imageManager:PHCachingImageManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //根据单元格的尺寸计算我们需要的缩略图大小
        let scale = UIScreen.main.scale
        let cellSize = CGSize(width: realValue(value: 396/2), height: realValue(value: 396/2));
        assetGridThumbnailSize = CGSize(width: cellSize.width*scale, height: cellSize.height*scale)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置左边的返回按钮
        var image = UIImage.imageWithName(name: "album_nav_backBtn");
        image = image?.withRenderingMode(.alwaysOriginal);
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(back));
        
        // 添加collectionView
        view.addSubview(collectionView);
        
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
        
        // 初始化和重置缓存
        self.imageManager = PHCachingImageManager()
        self.resetCachedAssets()
    
        
        // 注册cell
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: photoCellIdentifier);

        // Do any additional setup after loading the view.
    }
    
    // 点击左边按钮返回
    func back() -> Void {
        
        dismiss(animated: true, completion: nil);
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
        
        let asset = self.assetsFetchResults[indexPath.row];
        //获取缩略图
        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {
            (image, _) in
            
            cell.icon.image = image;
        })
        
        return cell
    }
    
    // 选中cell 进入详情页面
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let asset = self.assetsFetchResults[indexPath.row];
        //获取缩略图
        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { [weak self]
            (image, _) in
            
            if let delegate = self?.delegate, let image = image {
                delegate.dismissAlubmList(image);
            }
        })
    }
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        collectionView.frame = view.bounds;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
