//
//  ZXCollectionViewLayout.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2017/1/3.
//  Copyright © 2017年 zhangxu. All rights reserved.
//

import UIKit

class ZXCollectionViewLayout: UICollectionViewLayout {
    
    //section
    var numberOfSections: Int = 0;
    //section cell
    var numberOfCellsInSections: Int = 0;
    // columns
    var columnCount: Int = 0;
    //cell 列间距
    var minimumInteritemSpacing: CGFloat = 0.0;
    // 行间距
    var minimunLineitemSpacing: CGFloat = 0.0;
    //cell height
    var cellHeight: CGFloat = 0.0;
    // cell width
    var cellWidth: CGFloat = 0.0;
    // cell 高度数组
    private lazy var cellHeightArray: [CGFloat] = [CGFloat]();
    
    
    override func prepare() {
        
        guard let collectionView = self.collectionView else {
            return;
        }
        
        numberOfSections = collectionView.numberOfSections;
        numberOfCellsInSections = collectionView.numberOfItems(inSection: 0);
        columnCount = 6;
        cellWidth = realValue(value: 335/2);
        cellHeight = cellWidth;
        minimunLineitemSpacing = realValue(value: -1/2);
        minimumInteritemSpacing = minimunLineitemSpacing;
        
    }
    
    
    /**
     * 该方法返回CollectionView的ContentSize的大小
     */
    override var collectionViewContentSize: CGSize {
        let row = numberOfCellsInSections / columnCount;
        let width = cellWidth * CGFloat(columnCount) + minimumInteritemSpacing * CGFloat(columnCount - 1);
        let height = cellHeight * CGFloat(row) + minimunLineitemSpacing * CGFloat(row - 1);
        let size = CGSize(width: width, height: height);
        return size;
    }
    
    /**
     * 该方法为每个Cell绑定一个Layout属性~
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var array: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for index in 0..<numberOfCellsInSections {
            let indexPath = IndexPath.init(item: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexPath)
            array.append(attributes!)
        }
        return array
    }
    
    /**
     * 该方法为每个Cell绑定一个Layout属性~
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
    
        let cellX: CGFloat = cellWidth * CGFloat(indexPath.row % columnCount) + minimumInteritemSpacing * CGFloat(indexPath.row % columnCount - 1);
        let cellY: CGFloat = calculateY(indexPath: indexPath);
        let cellW: CGFloat = cellWidth;
        let cellH: CGFloat = cellHeight;
        let frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH);
        // 计算每个cell的位置
        attributes.frame = frame;
        
        return attributes
    }
    
    // 计算Y的值
    func calculateY(indexPath: IndexPath) -> CGFloat {
        
        let currentRow = indexPath.row / columnCount;
        let y = CGFloat(currentRow) * cellHeight + minimunLineitemSpacing * CGFloat(currentRow - 1);
        return y;
    }
    
}
