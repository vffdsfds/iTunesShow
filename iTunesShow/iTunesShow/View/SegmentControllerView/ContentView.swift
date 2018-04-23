//
//  ContentView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

//MARK:- delegate 11
protocol ContentViewDelegate :class {
    func contentView(_ contentView:ContentView,didEndScroll inIndex : Int)
    func contentView(_ contentView:ContentView,sourceIndex : Int,targetIndex : Int,progress : CGFloat)
}

class ContentView: UIView {
    
    //MARK:- delegate 22
    weak var delegate : ContentViewDelegate?
    
    fileprivate var childVCs : [UIViewController]
    fileprivate var parentVC : UIViewController
    fileprivate var fromOffsetX : CGFloat = 0
    fileprivate var isTitleClickForbidSVDelegate : Bool = false
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)//闭包中用到当前对象中的所有属性不能省略self.
        cv.dataSource = self
        cv.delegate = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.bounces = false
        cv.scrollsToTop = false//点击状态栏不要回到顶部
        return cv
    }()
    
    init(frame: CGRect,childVCs : [UIViewController],parentVC : UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}

extension ContentView{
    fileprivate func setupUI(){
        
        for childVC in childVCs{
            parentVC.addChildViewController(childVC)
        }
        addSubview(collectionView)
    }
}

extension ContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        //        cell.backgroundColor = UIColor.randomColor()
        
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension ContentView : UICollectionViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDidEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollDidEndScroll()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //记录开始拖动的offset
        fromOffsetX = scrollView.contentOffset.x
        isTitleClickForbidSVDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let toOffsetX = scrollView.contentOffset.x
        guard !isTitleClickForbidSVDelegate && toOffsetX != fromOffsetX else {
            return
        }
        
        var sourceIndex :Int = 0
        var targetIndex :Int = 0
        var progress : CGFloat = 0
        let collectionViewWidth = scrollView.bounds.width
        
        if toOffsetX > fromOffsetX {
            //左划向右滚 (回弹偶尔会调用右划向左滚，所以越界都要判断)
            sourceIndex = Int(toOffsetX / collectionViewWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count{
                targetIndex = childVCs.count - 1
                print(" --- \(toOffsetX) 到尾了--- ");
                return
            }
            /*
             progress = (toOffsetX - fromOffsetX) / collectionViewWidth
             if progress > 1 {
             progress = 1
             }
             */
            progress = toOffsetX/collectionViewWidth - floor(toOffsetX/collectionViewWidth)
            if toOffsetX - fromOffsetX == collectionViewWidth{
                progress = 1
                targetIndex = sourceIndex
            }
         
        }else{
            //右划向左滚（回调偶尔会调用左划向右滚）
            if toOffsetX<0 {
                print(" --- \(toOffsetX) 到头了--- ");
                return
            }
            
            targetIndex = Int(toOffsetX / collectionViewWidth)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count{//
                sourceIndex = childVCs.count - 1
            }
            progress = 1 - (toOffsetX/collectionViewWidth - floor(toOffsetX/collectionViewWidth))
         
            //完全划过去
            if fromOffsetX - toOffsetX == collectionViewWidth {
                progress = 1
                sourceIndex = targetIndex
            }
            
          
        }
        delegate?.contentView(self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
    
    private func scrollDidEndScroll(){
        //MARK:- delegate 33
        let index = Int( collectionView.contentOffset.x / collectionView.bounds.width )
        delegate?.contentView(self, didEndScroll: index)
    }
}

//MARK:- 代理 2
extension ContentView:TitleViewDelegate{
    func titleView(_ titleView: TitleView, targetIndex: Int) {
        isTitleClickForbidSVDelegate = true
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
    }
}

