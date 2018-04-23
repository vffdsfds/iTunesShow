//
//  PageView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

class PageView: UIView {
    fileprivate var titles : [String]
    fileprivate var childVCs : [UIViewController]
    fileprivate var parentVC : UIViewController
    fileprivate var titleStyle : PageStyle
    fileprivate var titleViewFrame=CGRect()
    init(frame: CGRect,titles : [String],titleStyle : PageStyle,childVCs : [UIViewController],parentVC : UIViewController) {
        self.titles = titles
        self.childVCs = childVCs
        self.parentVC = parentVC
        self.titleStyle = titleStyle
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageView{
    fileprivate func setupUI(){
        if UIDevice.current.isX()
        {
            titleViewFrame = CGRect(x: 0, y: 20, width: bounds.width, height: titleStyle.titleViewHeight)
            
        }else
        {
            titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: titleStyle.titleViewHeight)
            
        }
        let titleView = TitleView(frame:titleViewFrame,titles:titles,style:titleStyle)
        titleView.backgroundColor = UIColor.purple
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleViewFrame.maxY, width: bounds.width, height: bounds.height - titleStyle.titleViewHeight)
        let contentView = ContentView(frame: contentFrame, childVCs: childVCs, parentVC: parentVC)
        //        contentView.backgroundColor = .red
        addSubview(contentView)
        
      
        titleView.delegate = contentView
        
        contentView.delegate = titleView
    }
}
extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}

