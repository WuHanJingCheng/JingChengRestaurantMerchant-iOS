//
//  BlobManager.swift
//  BlobDemo1
//
//  Created by zhangxu on 2016/12/28.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import AZSClient

class BlobManager {
    
    private let connectionString = "DefaultEndpointsProtocol=https;AccountName=jingchengrestaurant;AccountKey=vgPX6U7Z3+r4X3CRqoX/bfwxaqAZwDccu1EzLKyAHfvtheHwypGy9o7ulhCLE/9+CNJqTPq8r4uGQ29/TWnN/w==";
    
    
    // 账户
    private let account: AZSCloudStorageAccount;
    
    // 客户端Blob
    private let blobClient: AZSCloudBlobClient;
    
    // 本地blob
    let blobContainer: AZSCloudBlobContainer;
    
    
    // 单粒
    static let shared: BlobManager = BlobManager();
    
    private init() {
        
        // 创建账户
        account = try! AZSCloudStorageAccount.init(fromConnectionString: connectionString);
        
        // 创建客户端Blob对象
        blobClient = account.getBlobClient();
        
        // 创建本地blob容器
        blobContainer = blobClient.containerReference(fromName: "localcontainer");
        
    }
  
    
    // 上传单张菜品图片到容器
    func uploadBlobToContainer(directory: String, blobName: String, data: Data, completionHandler: @escaping(_ containerError: Error?, _ error: Error?, _ blockBlob: AZSCloudBlockBlob?) -> ()) -> Void {
  
        // 如果容器不存在，创建一个存储容器
        blobContainer.createContainerIfNotExists(with: .blob, requestOptions: nil, operationContext: nil, completionHandler: {
            (error, _) in
            
            if let error = error {
                completionHandler(error, nil, nil);
                print("创建容器出错", error.localizedDescription);
            } else {
                
                // 创建一个本地blob对象
                let blockBlob = self.blobContainer.blockBlobReference(fromName: "menulist/\(directory)/\(blobName)\(base64encode(timeStamp())).jpg");
                
                // 上传blob到容器
                blockBlob.upload(from: data, completionHandler: { (error) in
                    
                    completionHandler(nil, error, blockBlob);
                })
            }
        });
    }
    
    // 上传普通状态和选中状态的图片到容器
    func uploadMoreBlobsToContainer(blobName: String, imageData_normal: Data?, imageData_selected: Data?, completionHandler: @escaping(_ containerError: Error?, _ normalError: Error?, _ normalBlob: AZSCloudBlockBlob?, _ selectedError: Error?, _ selectedBlob: AZSCloudBlockBlob?) -> ()) -> Void {
        
        // 如果容器不存在，创建一个存储容器
        blobContainer.createContainerIfNotExists(with: .blob, requestOptions: nil, operationContext: nil, completionHandler: {
            (error, _) in
            
            if let error = error {
                
                completionHandler(error, nil, nil, nil, nil);
            } else {
                
                // 创建组
                let group = DispatchGroup();
                
                // 存储普通图片的上传完成信息
                var normalError: Error?;
                var normalBlob: AZSCloudBlockBlob?;
                
                if let imageData_normal = imageData_normal {
                    
                    // 入组
                    group.enter();
                    
                    // 创建一个本地blob对象
                    let blockBlob1 = self.blobContainer.blockBlobReference(fromName: "menulist/\(blobName)/\(base64encode(timeStamp()))normal.jpg");
                    
                    // 上传blob到容器
                    blockBlob1.upload(from: imageData_normal, completionHandler: { (error) in
                        
                        normalError = error;
                        normalBlob = blockBlob1;
                        print("----------组1已出组");
                        
                        // 出组
                        group.leave();
                    })
                }
                
                // 存储选中状态的图片上传完成信息
                var selectedError: Error?;
                var selectedBlob: AZSCloudBlockBlob?;
                
                if let imageData_selected = imageData_selected {
                    
                    // 入组
                    group.enter();
                    
                    // 创建一个本地blob对象
                    let blockBlob2 = self.blobContainer.blockBlobReference(fromName: "menulist/\(blobName)/\(base64encode(timeStamp()))selected.jpg");
                    
                    // 上传blob到容器
                    blockBlob2.upload(from: imageData_selected, completionHandler: { (error) in
                        
                        selectedError = error;
                        selectedBlob = blockBlob2;
                        
                        print("-----------组2已出组");
                        
                        // 出组
                        group.leave();
                    })
                }
                
                // 监听是否全部出组
                group.notify(queue: DispatchQueue.main, execute: {
                    
                    print("-------------全部出组");
                    completionHandler(nil, normalError, normalBlob, selectedError, selectedBlob);
                })
            }
        });
    }
    
    // 上传一张缩略图和一张大图
    func uploadSmallImageAndLargeImageToBlob(directory: String, blobName: String, smallImageData: Data?, largeImageData: Data?, completionHandler: @escaping(_ containerError: Error?, _ smallError: Error?, _ smallBlob: AZSCloudBlockBlob?, _ largeError: Error?, _ largeBlob: AZSCloudBlockBlob?) -> ()) -> Void {
        
        blobContainer.createContainerIfNotExists(with: .blob, requestOptions: nil, operationContext: nil, completionHandler: {
            (error, isExist) in
            
            if let error = error {
                
                completionHandler(error, nil, nil, nil, nil);
            } else {
                
                // 创建组
                let group = DispatchGroup();

                var smallError: Error?;
                var smallBlob: AZSCloudBlockBlob?;
                var largeError: Error?;
                var largeBlob: AZSCloudBlockBlob?;
                
                if let smallImageData = smallImageData {
                    
                    // 入组
                    group.enter();
                    
                    // 创建一个本地blob对象
                    let blockBlob1 = self.blobContainer.blockBlobReference(fromName: "menulist/\(directory)/\(blobName)\(base64encode(timeStamp()))small.jpg");
                    
                    // 上传blob到容器
                    blockBlob1.upload(from: smallImageData, completionHandler: { (error) in
                        
                        smallError = error;
                        smallBlob = blockBlob1;
                        print("-----------组2已出组");
                        
                        // 出组
                        group.leave();
                    })
                }
                
                if let largeImageData = largeImageData {
                    
                    // 入组
                    group.enter();
                    
                    // 创建一个本地blob对象
                    let blockBlob2 = self.blobContainer.blockBlobReference(fromName: "menulist/\(directory)/\(blobName)\(base64encode(timeStamp()))large.jpg");
                    
                    // 上传blob到容器
                    blockBlob2.upload(from: largeImageData, completionHandler: { (error) in
                        
                        largeError = error;
                        largeBlob = blockBlob2;
                        print("-----------组2已出组");
                        
                        // 出组
                        group.leave();
                    })
                }
                
                // 监听是否全部出组
                group.notify(queue: DispatchQueue.main, execute: {
                    
                    print("-------------全部出组");
                    completionHandler(nil, smallError, smallBlob, largeError, largeBlob);
                })
            }
        });
    }
    
    
    // 下载Blob
    func downloadBlob(blobName: String, completionHandler: @escaping(_ error: Error?, _ data: Data?, _ blockBlob: AZSCloudBlockBlob) -> ()) -> Void {
        
        // 创建一个本地blob对象
        let blockBlob = blobContainer.blockBlobReference(fromName: blobName);
        
        // 下载文件
        blockBlob.downloadToData { (error, data) in
            
            completionHandler(error, data, blockBlob);
        }
    }
    
    // 删除blob
    func deleteBlob(blobName: String, completionHandler: @escaping(_ error: Error?, _ blockBlob: AZSCloudBlockBlob) -> ()) -> Void {
        // 创建本地blob对象
        let blockBlob = blobContainer.blockBlobReference(fromName: blobName);
        // 删除blob
        blockBlob.delete { (error) in
            
            completionHandler(error, blockBlob);
        }
    }
    
    // 删除blob容器
    func deleteContainer(blobName: String, completionHandler: @escaping(_ error: Error?, _ blockBlob: AZSCloudBlockBlob) -> ()) -> Void {
        
        // 创建一个本地blob对象
        let blockBlob = blobContainer.blockBlobReference(fromName: blobName);
        // 删除blob
        blockBlob.delete { (error) in
            
            completionHandler(error, blockBlob);
        }
    }
}
