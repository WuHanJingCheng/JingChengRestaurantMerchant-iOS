//
//  JCDishModel.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/5.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class JCDishModel: NSObject {
    
    var isSelected: Bool = false;
    var index: Int?;
    
    // 保存上传的信息
    var directory: String?; // 图片存放目录
    var imageData: Data?;// 缩略图
    var largeImageData: Data? // 大图
    var DishUrl: String?;
    
    
    // 服务器字段
    var DishId: Int?;
    var DishName: String?;
    var Price: Double?;
    var Thumbnail: String?;
    var PictureUrlLarge: String?;
    var Recommanded: Bool?;
    var Detail: String?;
    
    
    // 初始化,字典转模型
    class func modelWithDic(dict: [String: Any]) -> JCDishModel {
        
        let model = JCDishModel();
        model.DishName = dict["DishName"] as? String;
        model.Thumbnail = dict["Thumbnail"] as? String;
        model.PictureUrlLarge = dict["PictureUrlLarge"] as? String;
        model.Price = dict["Price"] as? Double;
        model.DishId = dict["DishId"] as? Int;
        model.Detail = dict["Detail"] as? String;
        model.Recommanded = dict["Recommanded"] as? Bool;
        return model;
    }

}
