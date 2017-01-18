//
//  HttpManager.swift
//  JingChengRestaurant-Swift
//
//  Created by zhangxu on 16/7/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import AFNetworking




// 定义枚举类型
enum RequestType : String {
    case GET = "GET"
    case POST = "POST"
}

class HttpManager: AFHTTPSessionManager {
    
    // let是线程安全的
    static let shared : HttpManager = {
        let tools = HttpManager()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
}

extension HttpManager {
    
    func request(_ methodType : RequestType, urlString : String, parameters : [String : Any]?, finished : @escaping(_ result : Any?, _ task: URLSessionDataTask?, _ error : Error?) -> ()) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask, result : Any?) -> Void in
            
            finished(result, task, nil);
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : URLSessionDataTask?, error : Error) -> Void in
            finished(nil, task, error);
        }
        
        // 3.发送网络请求
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack);
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
    
}


extension HttpManager {
    
    
    // 上传菜品分类列表
    func uploadSubMenuList(url: String, parameters: [String: Any], succussCallBack: @escaping(_ data: Data?, _ httpResponse: HTTPURLResponse?) -> (), failureCallBack: @escaping(_ error: Error?) -> ()) {
        // 开启一个线程
        DispatchQueue.global().async {
            
            // 发送POST请求
            var request = URLRequest.init(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10);
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type");
            request.httpMethod = "POST";
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted);
            request.httpBody = jsonData;
            let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                // 回到主线程
                DispatchQueue.main.async {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return;
                    };
                    
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 || httpResponse.statusCode == 304 {
                        succussCallBack(data, httpResponse);
                    } else {
                        failureCallBack(error);
                    }
                }
            });
            
            session.resume();
        }
    }
    
    // 修改子菜单分类 或修改菜品数据
    func modifityServerData(url: String, parameters: [String: Any], succussCallBack: @escaping(_ data: Data?, _ httpResponse: HTTPURLResponse?) -> (), failureCallBack: @escaping(_ error: Error?) -> ()) -> Void {
        
        // 开启一个线程
        DispatchQueue.global().async {
            
            // 发送PUT请求
            var request = URLRequest.init(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10);
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type");
            request.httpMethod = "PUT";
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted);
            request.httpBody = jsonData;
            let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                // 回到主线程
                DispatchQueue.main.async {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return;
                    };
                    
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 || httpResponse.statusCode == 304 {
                        succussCallBack(data, httpResponse);
                    } else {
                        failureCallBack(error);
                    }
                }
            });
            
            session.resume();
        }
    }
    
    // 删除子菜单分类
    func deleteServerData(url: String, succussCallBack: @escaping(_ data: Data?, _ httpResponse: HTTPURLResponse?) -> (), failureCallBack: @escaping(_ error: Error?) -> ()) -> Void {
        
        // 开启一个线程
        DispatchQueue.global().async {
            
            // 发送PUT请求
            var request = URLRequest.init(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10);
            request.httpMethod = "DELETE";
            let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                // 回到主线程
                DispatchQueue.main.async {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return;
                    };
                    
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 || httpResponse.statusCode == 304 {
                        succussCallBack(data, httpResponse);
                    } else {
                        failureCallBack(error);
                    }
                }
            });
            
            session.resume();
        }
    }
}


