//
//  PhotoDetailController.swift
//  CustomAlbum
//
//  Created by zhangxu on 2016/12/15.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import Photos


class PhotoDetailController: UIViewController {
    
    var boxWidth: CGFloat = 0;
    var boxHeight: CGFloat = 0;
    
    var shotScreenW: CGFloat = 0;
    var shotScreenH: CGFloat = 0;
    
    var shotScale: CGFloat = 0;
    
    
    var asset: PHAsset?;
    
    lazy var icon: UIImageView = {
        let icon = UIImageView();
        icon.contentMode = .scaleAspectFit;
        icon.isUserInteractionEnabled = true;
        icon.clipsToBounds = true;
        icon.contentMode = .scaleAspectFit;
        return icon;
    }();
    
    private lazy var cover: UIImageView = {
        let cover = UIImageView();
        cover.image = UIImage.imageWithName(name: "album_area_shotscreen_84x64");
        return cover;
    }();
    
    
    var shotScreenType: String?;
    
    // 截图回调
    var screenshotCallBack: ((_ image: UIImage, _ vc: UIViewController) -> ())?;
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false;
        
        let image = UIImage.imageWithName(name: "submenulist_backbtn");
        let originalImage = image?.withRenderingMode(.alwaysOriginal);
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: originalImage, style: .plain, target: self, action: #selector(back));
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "选中", style: .plain, target: self, action: #selector(selectedClick));
        
        // 设置颜色为无色
        view.backgroundColor = UIColor.clear;
        
        // 添加icon
        view.addSubview(icon);
        
        view.addSubview(cover);
        
        
        icon.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 0);
        
        // 判断区域
        if shotScreenType == "84x64" {
            cover.image = UIImage.imageWithName(name: "album_area_shotscreen_84x64");
            boxWidth = realValue(value: 1344/2 + 2);
            boxHeight = realValue(value: 1024/2 + 2);
        } else {
            cover.image = UIImage.imageWithName(name: "album_area_shotscreen_1390x1043");
            boxWidth = realValue(value: 1390/2 + 2);
            boxHeight = realValue(value: 1043/2 + 2);
        }
        
        shotScreenW = boxWidth - realValue(value: 2);
        shotScreenH = boxHeight - realValue(value: 2);
        shotScale = shotScreenW/kScreenWidth;
        
//        setupBoxLayer();
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(pan:)));
        icon.addGestureRecognizer(pan);
        
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchAction(pinch:)));
        icon.addGestureRecognizer(pinch);

        
        // 获取可选类型中的数据
        guard let asset = asset else {
            return;
        }
        
        _ = PhotoHandler.shared.getPhotosWithAsset(asset: asset, isOriginalImage: true, completion: { (image) in
            
            let height = self.icon.frame.size.width * image.size.height/image.size.width;
            self.icon.frame = CGRect(x: 0, y: 0, width: self.icon.frame.size.width, height: height);
            self.icon.center = self.view.center;
            self.cover.frame = self.view.bounds;
            
            guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
                return;
            }
            self.icon.image = UIImage.init(data: imageData);

        })
        
        
        // Do any additional setup after loading the view.
    }
    
    func selectedClick() -> Void {
        
        guard let image = captureImageFromView() else {
            return;
        }
        if let screenshotCallBack = screenshotCallBack {
            screenshotCallBack(image, self);
        }
        
    }
 
    // 按区域截图
    func captureImageFromView() -> UIImage? {
        
        let width = self.view.bounds.size.width;
        let height = self.view.bounds.size.height;
        let screenRect = CGRect(x: (width - shotScreenW), y: (height - shotScreenH), width: shotScreenW * 2, height: shotScreenH * 2);

        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale);
        
        let context: CGContext? = UIGraphicsGetCurrentContext();
       
        
        if context == nil {
            return nil;
        }
 
        self.view.layer.render(in: context!);
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        let imageRef = image.cgImage?.cropping(to: screenRect);
        let newImage = UIImage.init(cgImage: imageRef!);
        UIGraphicsEndImageContext();
        
        return newImage;

    }
    
    // 平移手势
    func panAction(pan: UIPanGestureRecognizer) -> Void {
      
        guard let panView = pan.view else {
            return;
        }
        
        let width = view.frame.size.width;
        let height = view.frame.size.height;
        let translation = pan.translation(in: panView.superview);
        panView.center = CGPoint(x: panView.center.x + translation.x, y: panView.center.y + translation.y);
        pan.setTranslation(.zero, in: panView.superview);
        // 不能上出选择框
        if panView.frame.origin.x >= (width - boxWidth)/2 {
            
            panView.frame = CGRect(x: (width - boxWidth)/2, y: panView.frame.origin.y, width: panView.frame.size.width, height: panView.frame.size.height);
        }
        
        // 不能右出选择框
        if panView.frame.origin.y >= (height - boxHeight)/2 {
            
            panView.frame = CGRect(x: panView.frame.origin.x, y: (height - boxHeight)/2, width: panView.frame.size.width, height: panView.frame.size.height);
        }
        
        // 不能下出选择框
        let scaleH = panView.frame.size.height;
        if panView.frame.origin.y <= -(scaleH - (height - boxHeight)/2 - boxHeight) {
            panView.frame = CGRect(x: panView.frame.origin.x, y: -(scaleH - (height - boxHeight)/2 - boxHeight), width: panView.frame.size.width, height: panView.frame.size.height);
        }

        // 不能左出选择框
        let scaleW = panView.frame.size.width;
        if panView.frame.origin.x <= -(scaleW - (width - boxWidth)/2 - boxWidth) {
            
            panView.frame = CGRect(x: -(scaleW - (width - boxWidth)/2 - boxWidth), y: panView.frame.origin.y, width: panView.frame.size.width, height: panView.frame.size.height);
        }

    }
    
    // 捏合手势
    func pinchAction(pinch: UIPinchGestureRecognizer) -> Void {
        
        guard let pinchView = pinch.view else {
            return;
        }
        
        pinchView.transform = pinchView.transform.scaledBy(x: pinch.scale, y: pinch.scale);
        
        if pinchView.transform.a > 1.5 {
            var transform: CGAffineTransform = pinchView.transform;
            transform.a = 1.5;
            transform.d = 1.5;
            pinchView.transform = transform;
        }
        
        if pinchView.transform.a < shotScale {
            
            var transform: CGAffineTransform = pinchView.transform;
            transform.a = shotScale;
            transform.d = shotScale;
            pinchView.transform = transform;
        }
        
        
        pinch.scale = 1;
        
    }
    
    func back() -> Void {
        
        self.navigationController!.popViewController(animated: false);
    }
    
   
    // 缩略图
    func thumbnailsCutfullPhoto(photo: UIImage) -> UIImage? {
        
        var newSize: CGSize = .zero;
        
        if photo.size.width/photo.size.height < 1 {
            newSize.width = photo.size.width;
            newSize.height = photo.size.width * 1;
        } else {
            newSize.height = photo.size.height;
            newSize.width = photo.size.height * 1;
        }
        
        
        UIGraphicsBeginImageContext(newSize);
        
        photo.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height));
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
    }
    
    /**
     获取具体的图片
     
     @param asset         PHAsset 对象
     @param originalImage 是否是原图(YES为原图. NO 为缩略图.默认我 NO)
     @param completion     成功的回调
     
     @return 唯一地标识一个可删除的异步请求
     */
    func getPhotosWithAsset(asset: PHAsset, isOriginalImage: Bool, completion: ((_ image: UIImage) -> ())?) -> PHImageRequestID {
        
        var size: CGSize?;
        
        if isOriginalImage == true {
            size = PHImageManagerMaximumSize;
        } else {
            let scale = UIScreen.main.scale;
            size = CGSize(width: 125 * scale, height: 125 * scale);
        }
        
        let options = PHImageRequestOptions();
        options.resizeMode = .fast;
        
        let imageRequestID = PHImageManager.default().requestImage(for: asset, targetSize: size!, contentMode: .aspectFill, options: options, resultHandler: {
            (image, info) in
            
            guard let info = info as? [String: Any] else {
                return;
            }
            
            let downloadFinished: Bool? = ((info[PHImageCancelledKey] as? NSNumber)?.boolValue == nil && info[PHImageErrorKey] == nil);
            
            if downloadFinished != nil && image != nil {
                if isOriginalImage == false {
                    
                    let newImage = self.thumbnailsCutfullPhoto(photo: image!);
                    
                    if let completion = completion {
                        completion(newImage!);
                    }
                } else {
                    
                    if let completion = completion {
                        completion(image!);
                    }
                }
            }
        })
        return imageRequestID;
    }
    
    
    func setupBoxLayer() -> Void {
        
        let width = self.view.frame.size.width;
        let height = self.view.frame.size.height - 64;
       
        addShapeLayerWithFrame(frame: CGRect(x: 0, y: 0, width: width, height: (height - boxHeight)/2), strokeColor: UIColor.clear, fillColor: UIColor.init(white: 0.2, alpha: 0.2));
        addShapeLayerWithFrame(frame: CGRect(x: 0, y: (height - boxHeight)/2, width: (width - boxWidth)/2, height: boxHeight), strokeColor: UIColor.clear, fillColor: UIColor.init(white: 0.2, alpha: 0.2));
        addShapeLayerWithFrame(frame: CGRect(x: 0, y: height/2 + boxHeight/2, width: width, height: height/2 - boxHeight/2), strokeColor: UIColor.clear, fillColor: UIColor.init(white: 0.2, alpha: 0.2));
        addShapeLayerWithFrame(frame: CGRect(x: (width - boxWidth)/2 + boxWidth, y: height/2 - boxHeight/2, width: width - boxWidth - (width - boxWidth)/2, height: boxHeight), strokeColor: UIColor.clear, fillColor: UIColor.init(white: 0.2, alpha: 0.2));
        addShapeLayerWithFrame(frame: CGRect(x: (width - boxWidth)/2, y: height/2 - boxHeight/2, width: boxWidth, height: boxHeight), strokeColor: UIColor.lightGray, fillColor: UIColor.clear);

    }
    
    
    func addShapeLayerWithFrame(frame: CGRect, strokeColor: UIColor, fillColor: UIColor) -> Void {
        
        let width = self.view.bounds.size.width;
        let height = self.view.bounds.size.height - 64;
        
        let rectRangePath = UIBezierPath.init(rect: frame);
        rectRangePath.lineWidth = 1;
        let shapeLayer = CAShapeLayer();
        shapeLayer.frame = CGRect(x: 0, y: 0, width: width, height: height);
        self.view.layer.insertSublayer(shapeLayer, above: icon.layer);
        shapeLayer.strokeColor = strokeColor.cgColor;
        shapeLayer.fillColor = fillColor.cgColor;
        shapeLayer.path = rectRangePath.cgPath;
        
    }

    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
