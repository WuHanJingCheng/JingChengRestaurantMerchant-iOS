//
//  JCMiddleModel.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCMiddleModel: NSObject {
    
    var name: String?;
    var img_url_normal: String?;
    var img_url_selected: String?;
    var jsonFileName: String?;
    var isSelected: Bool = false;
    
    // 字段转模型
    class func modelWidthDict(dict: [String: Any]) -> JCMiddleModel {
        
        let model = JCMiddleModel();
        model.name = dict["name"] as? String ?? "";
        model.img_url_normal = dict["img_url_normal"] as? String ?? "";
        model.img_url_selected = dict["img_url_selected"] as? String ?? "";
        return model;
    }

}
