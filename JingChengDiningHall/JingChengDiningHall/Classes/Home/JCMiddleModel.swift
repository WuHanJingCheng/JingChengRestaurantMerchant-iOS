//
//  JCMiddleModel.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.

import UIKit

class JCMiddleModel: NSObject {
    
    // 服务器字段
    var DishUrl: String?;
    var MenuId: Int?;
    var MenuName: String?;
    var PictureUrl: String?;
    var PictureUrlSelected: String?;
    
    // 自定义字段
    var image_normal_data: Data?;
    var image_selected_data: Data?;
    var imageType: ImageType?;
    var isSelected: Bool = false;
    var index: Int?;
    
   
    
    // 字段转模型
    class func modelWidthDict(dict: [String: Any]) -> JCMiddleModel {
        
        let model = JCMiddleModel();
        model.DishUrl = dict["DishUrl"] as? String ?? "";
        model.MenuId =  dict["MenuId"] as? Int ?? 0;
        model.MenuName = dict["MenuName"] as? String ?? "";
        model.PictureUrl = dict["PictureUrl"] as? String ?? "";
        model.PictureUrlSelected = dict["PictureUrlSelected"] as? String ?? "";
        
        return model;
    }

}
