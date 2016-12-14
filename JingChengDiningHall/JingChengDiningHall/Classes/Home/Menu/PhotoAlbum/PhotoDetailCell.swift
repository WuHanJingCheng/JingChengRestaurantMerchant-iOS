//
//  PhotoDetailCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/10.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailCell: UICollectionViewCell {
    
    // 图片
    private lazy var photo: UIImageView = {
        let photo = UIImageView();
        photo.isUserInteractionEnabled = true;
        photo.backgroundColor = UIColor.black;
        return photo;
    }();
    
    var asset: PHAsset? {
        didSet {
            // 获取可选类型中的数据
            guard let asset = asset else {
                return;
            }
            
            let width = kScreenWidth;
            let height = kScreenHeight - realValue(value: 64);
            
            var photoW: CGFloat = 0;
            var photoH: CGFloat = 0;
            
            let imageW = CGFloat(asset.pixelWidth);
            let imageH = CGFloat(asset.pixelHeight);
            let ratioW = imageW/width;
            let ratioH = imageH/height;
            
            photoW = width;
            photoH = imageH/ratioW;
            
            if photoH > height {
                photoH = height;
                photoW = imageW/ratioH;
            }
            
            let size = CGSize(width: photoW, height: photoH);

            let options = PHImageRequestOptions();
            options.isSynchronous = true;
            options.resizeMode = .exact;
            options.isNetworkAccessAllowed = true;
            
            PHCachingImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options, resultHandler: { [weak self]
                (image, _) in
                self?.photo.image = image;
            })
        }
    };
    
    
    // 是否显示选中按钮
    var isShow: Bool = false;
    // 点击图片的回调
    var pickerImageCallBack: ((_ isShow: Bool) -> ())?;
    
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加图片
        contentView.addSubview(photo);
        
        // 添加轻拍手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction));
        photo.addGestureRecognizer(tap);
        
    }
    
    // 轻拍手势
    func tapAction() -> Void {
        
        self.isShow = !self.isShow;
        
        if let pickerImageCallBack = pickerImageCallBack {
            pickerImageCallBack(isShow);
        }
    }
    
    // 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        if let asset = asset {
            
            let width = bounds.size.width;
            let height = bounds.size.height;
            
            var photoW: CGFloat = 0;
            var photoH: CGFloat = 0;
            
            let imageW = CGFloat(asset.pixelWidth);
            let imageH = CGFloat(asset.pixelHeight);
            let ratioW = imageW/width;
            let ratioH = imageH/height;
            
            photoW = width;
            photoH = imageH/ratioW;
            
            if photoH > height {
                photoH = height;
                photoW = imageW/ratioH;
            }
            
            let photoCenterX = width/2;
            let photoCenterY = height/2;
            
            photo.center = CGPoint(x: photoCenterX, y: photoCenterY);
            photo.bounds = CGRect(x: 0, y: 0, width: photoW, height: photoH);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
