//
//  CXCollectionView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

class CXCollectionView: UICollectionViewFlowLayout {

    private(set) var ColumnCountDefault : Int = 3
    private(set) var ColumnMargin : CGFloat = 10.0
    private(set) var ItemMargin : CGFloat = 10.0
    private(set) var EdgeInsetsDefault : UIEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    
    lazy var attrsArray = [UICollectionViewLayoutAttributes]()
    lazy var columnHeightsAry = [CGFloat]()
    
    
    override func prepare() {
        super.prepare()
        columnHeightsAry.removeAll()
        
        for _ in 0 ..< ColumnCountDefault {
            columnHeightsAry.append(EdgeInsetsDefault.top)
        }
        
        attrsArray.removeAll()
        
        let sections : Int = (self.collectionView?.numberOfSections)!
        
        for num in 0 ..< sections {
            let count : Int = (self.collectionView?.numberOfItems(inSection: num))!//获取分区0有多少个item
            for i in 0 ..< count {
                let indexpath : NSIndexPath = NSIndexPath.init(item: i, section: num)
                let attrs = self.layoutAttributesForItem(at: indexpath as IndexPath)!
                
                attrsArray.append(attrs)
            }
        }
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let collectionWidth = self.collectionView?.frame.size.width
        
        let __W = (collectionWidth! - EdgeInsetsDefault.left - EdgeInsetsDefault.right - CGFloat(ColumnCountDefault-1) * ColumnMargin) / CGFloat(ColumnCountDefault)
        let __H = 100 + arc4random_uniform(100)
        
        var dextColum : Int = 0
        var mainH = columnHeightsAry[0]
        
        for i in 1 ..< ColumnCountDefault{
            let columnH = columnHeightsAry[i]
            
            if mainH > columnH {
                mainH = columnH
                dextColum = i
            }
        }
        
        //  print(dextColum)
        
        let x = EdgeInsetsDefault.left + CGFloat(dextColum) * (__W + ColumnMargin)
        var y = mainH
        
        if y != EdgeInsetsDefault.top{
            y = y + ItemMargin
        }
        attrs.frame = CGRect(x: x, y: y, width: __W, height: CGFloat(__H))
        columnHeightsAry[dextColum] = attrs.frame.maxY
        // print("frame\(attrs.frame.maxY)")
        
        // print("frame\(attrs.frame)")
        return attrs
    }
    
    override var collectionViewContentSize: CGSize {
        
        var maxHeight = columnHeightsAry[0]
        
        for i in 1 ..< ColumnCountDefault {
            let columnHeight = columnHeightsAry[i]
            
            if maxHeight < columnHeight {
                maxHeight = columnHeight
            }
        }
        
        return CGSize.init(width: 0, height: maxHeight + EdgeInsetsDefault.bottom)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attrsArray
    }
}

