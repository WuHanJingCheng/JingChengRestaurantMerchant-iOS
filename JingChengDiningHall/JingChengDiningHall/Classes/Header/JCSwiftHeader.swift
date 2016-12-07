//
//  JCSwiftHeader.swift
//  AlphaRestaurant
//
//  Created by zhangxu on 16/9/28.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation
import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width;
let kScreenHeight = UIScreen.main.bounds.size.height;

extension UIImage {
    
    class func imageWithName(name: String) -> UIImage? {
        
        let imageName = isiPadPro_12_9_Inch() ? name + "_2048x1536@2x.png" : name + "_2048x1536@2x.png";
        let image = UIImage(named: imageName);
        return image;
    }
}

extension UIButton {
    
    class func buttonWithTitle(title: String) -> UIButton {
        
        let button = UIButton(type: .custom);
        button.setBackgroundImage(UIImage.imageWithName(name: "order_numberbtn_border"), for: .normal);
        button.setTitle(title, for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x4c4c4c), for: .normal);
        button.titleLabel?.font = Font(size: 32/2);
        return button;
        
    }
}

// 通知名称
let SendSubMenusNotification = Notification.Name("SendSubMenusNotification");
let SendSubMenuContentNotification = Notification.Name("SendSubMenuContentNotification");

// 是否是12.9 inch
func isiPadPro_12_9_Inch() -> Bool {
    
    return (kScreenWidth == 1366.0) ? true : false;
}

// 根据文字返回宽度
func calculateWidth(title: String, fontSize: CGFloat) -> CGFloat {
    
    var attribute = [String: AnyObject]();
    attribute[NSFontAttributeName] = Font(size: fontSize);
    let width = title.size(attributes: attribute).width;
    return width;
}

// RGB
func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    
    let color = UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1);
    return color;
}

// 16进制色码
func RGBWithHexColor(hexColor: Int) -> UIColor {
    
    let red = ((hexColor & 0xFF0000) >> 16);
    let green = ((hexColor & 0xFF00) >> 8);
    let blue = (hexColor & 0xFF);
    let color = RGB(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue));
    return color;
}

// 设置字体大小
func Font(size: CGFloat) -> UIFont {
    
    let font = UIFont.systemFont(ofSize: realValue(value: size));
    return font;
}

// 设置粗体
func BoldFont(size: CGFloat) -> UIFont {
    
    let font = UIFont.boldSystemFont(ofSize: realValue(value: size));
    return font;
}

// 真实值
func realValue(value: CGFloat) -> CGFloat {
    
    let realValue = value / 1024 * kScreenWidth;
    return realValue;
}

// 延迟执行
func delayCallBack(_ time : CGFloat, callBack : (() -> ())?) -> Void {
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(time) * __int64_t(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
        
        if let callBack = callBack {
            callBack();
        }
    })
    
}


