//
//  JCPhotoDetailController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/10.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let photoDetailCellIdentifier = "photoDetailCellIdentifier";
    
    // collectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - realValue(value: 64));
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - realValue(value: 64)), collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.isPagingEnabled = true;
        return collectionView;
    }();
    
    // 选中按钮
    private lazy var pickerBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.backgroundColor = UIColor.blue;
        button.setTitle("选中", for: .normal);
        button.titleLabel?.font = Font(size: 15);
        button.setTitleColor(UIColor.white, for: .normal);
        button.isHidden = true;
        return button;
    }();
    
    
    // 相册数组
    var assets: [PHAsset]?;
    // 选中的位置
    var indexPath: IndexPath?;
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
        collectionView.register(PhotoDetailCell.self, forCellWithReuseIdentifier: photoDetailCellIdentifier);
        
        // 改变偏移量
        if let indexPath = indexPath {
            collectionView.scrollToItem(at: indexPath, at: .right, animated: false);
        }
        
    }
    
    func selectedImage() -> Void {
        
        let cell = collectionView.visibleCells[0];
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return;
        };
        
        if let assets = assets {
            let asset = assets[indexPath.row];
            
            let options = PHImageRequestOptions();
            options.isSynchronous = true;
            options.resizeMode = .exact;
            options.deliveryMode = .highQualityFormat;
            options.isNetworkAccessAllowed = true;
            
            let size = CGSize(width: realValue(value: 100), height: realValue(value: 100));
            
            PHCachingImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options, resultHandler: { [weak self]
                (image, _) in
                
                if let selectedImageCallBack = self?.selectedImageCallBack, let image = image {
                    selectedImageCallBack(image);
                }
            })
        }
    }

    // 返回行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let assets = assets {
            return assets.count;
        }
        return 0;
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoDetailCellIdentifier, for: indexPath) as? PhotoDetailCell;
        let asset = assets?[indexPath.row];
        cell?.asset = asset;
        cell?.pickerImageCallBack = { [weak self]
            (isShow) in
            if isShow == true {
                
                let selectedBtn = UIButton(type: .custom);
                selectedBtn.frame = CGRect(x: 0, y: 0, width: realValue(value: 50), height: realValue(value: 40));
                selectedBtn.setTitle("选中", for: .normal);
                selectedBtn.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
                selectedBtn.titleLabel?.font = Font(size: 15);
                selectedBtn.addTarget(self, action: #selector(self?.selectedImage), for: .touchUpInside);
                
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: selectedBtn);
            } else {
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: nil, style: .plain, target: nil, action: nil);
            }
            
            
        }
        return cell!;
    }
    
    // 点击左边按钮返回
    func back() -> Void {
        
        let _ = self.navigationController?.popViewController(animated: true);
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("PhotoDetailController 释放了");
        // Dispose of any resources that can be recreated.
    }

}
