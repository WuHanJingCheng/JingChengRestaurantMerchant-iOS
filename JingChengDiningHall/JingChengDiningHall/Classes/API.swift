
//
//  API.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/3.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import Foundation

/******************************子菜单增删改********************************/
// 上传菜品分类
func submenulistUrl(restaurantId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/Restaurant/\(restaurantId)/menu";
    return url;
}


// 修改单个子菜单
func submenuURL(MenuId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/Menu/\(MenuId)";
    return url;
}

// 删除子菜单接口
func deleteSubMenuURL(MenuId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/Menu/\(MenuId)";
    return url;
}
/******************************子菜单增删改********************************/












/******************************菜品增删改********************************/
// 给单个分类上传菜品
func dishlistUrl(MenuId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/menu/\(MenuId)/dish";
    return url;
}

// 修改菜品信息
func modifityDishUrl(DishId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/Dish/\(DishId)";
    return url;
}

// 删除菜品
func deleteDishUrl(DishId: Int) -> String {
    
    let url = "https://jingchengrestaurant.azurewebsites.net/api/Dish/\(DishId)";
    return url;
}
/******************************菜品增删改********************************/

