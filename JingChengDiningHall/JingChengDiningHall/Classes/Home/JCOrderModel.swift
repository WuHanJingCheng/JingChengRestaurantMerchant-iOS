//
//  JCOrderModel.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit



class JCOrderModel: NSObject {
    
    
    /*
     * tag = 0  就餐
     * tag = 1  空闲
     * tag = 2  停用
    */
    var tag: Int = 0;
    
    // 是否为选中状态
    var isSelected: Bool = false;
    
}
