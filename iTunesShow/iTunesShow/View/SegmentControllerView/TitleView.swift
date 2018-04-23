//
//  TitleView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

protocol TitleViewDelegate:class {//1 NSObjectProtocol 2 class 只能被类遵守
    func titleView(_ titleView :TitleView,targetIndex:Int)
}

class TitleView: UIView {
    
    //MARK:delegate 2
    weak var delegate : TitleViewDelegate?
    
    fileprivate var titles : [String]
    fileprivate var titleStyle : PageStyle
    
    fileprivate lazy var scrollView : UIScrollView = {
        let sv  = UIScrollView(frame:self.bounds)
        sv.showsHorizontalScrollIndicator = false
        sv.scrollsToTop = false//点击状态栏不要回到顶部
        return sv
    }()
    
    fileprivate var currentIndex = 0
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()

    
    fileprivate lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = self.titleStyle.bottomLineColor
        return bottomLine
    }()
    
    fileprivate lazy var coverView : UIView = {
        let coverV = UIView()
        coverV.backgroundColor = self.titleStyle.coverBgColor
        coverV.alpha = self.titleStyle.coverAlpha
        return coverV
    }()
    
    init(frame: CGRect,titles : [String],style : PageStyle) {
        self.titles = titles
        self.titleStyle = style
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TitleView {
    fileprivate func setupUI(){
        addSubview(scrollView)
        setupLabels()
        setupBottomLine()
        setupCoverView()
    }
    
    private func setupCoverView(){
        if titleStyle.isShowCoverView{
            scrollView.insertSubview(coverView, at: 0)//scrollView.addSubview(coverView)
            guard let firstLabel = titleLabels.first else {
                return
            }
            
            //MARK:- 可滚动不可滚动 有下划线没有下划线 共4种组合情况的处理 1
            var coverX : CGFloat = titleStyle.isShowBottomLine ? bottomLine.frame.origin.x : firstLabel.frame.origin.x
            //let coverY : CGFloat = (firstLabel.frame.height - titleStyle.coverHeight) * 0.5
            let coverY : CGFloat = (titleStyle.titleViewHeight - titleStyle.coverHeight) * 0.5
            var coverW : CGFloat = titleStyle.isShowBottomLine ? bottomLine.frame.width : firstLabel.frame.width
            let coverH : CGFloat = titleStyle.coverHeight
            
            //没有滚动条且可滚动
            if !titleStyle.isShowBottomLine && titleStyle.isScrollEnable{
                coverX -= titleStyle.coverMargin
                coverW += titleStyle.coverMargin * 2
            }
            //没有滚动条且不可滚动
            if !titleStyle.isShowBottomLine && !titleStyle.isScrollEnable{//等分
                coverX += titleStyle.coverMargin
                coverW -= titleStyle.coverMargin * 2
            }
            
            coverView.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
            coverView.layer.cornerRadius = titleStyle.coverRadius
            coverView.layer.masksToBounds = true
        }
    }
    
    private func setupBottomLine(){
        if titleStyle.isShowBottomLine {
            scrollView.addSubview(bottomLine)
            bottomLine.frame = titleLabels.first!.frame
            //MARK:- 等分情况下的滚动条 1
            if !titleStyle.isScrollEnable{
                bottomLine.frame.origin.x +=  titleStyle.bottomLineExtendWidth
                bottomLine.frame.size.width -=  2 * titleStyle.bottomLineExtendWidth
            }else{
                bottomLine.frame.origin.x -=  titleStyle.bottomLineExtendWidth
                bottomLine.frame.size.width +=  2 * titleStyle.bottomLineExtendWidth
            }
            bottomLine.frame.size.height = titleStyle.bottomLineHeight
            bottomLine.frame.origin.y = titleStyle.titleViewHeight - titleStyle.bottomLineHeight - titleStyle.bottomLineMargin
        }
    }
    
    private  func setupLabels(){
        for (i,title) in titles.enumerated(){
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = (i==0 ? titleStyle.selectColor : titleStyle.normalColor)
            titleLabel.font = titleStyle.titleFont
            scrollView.addSubview(titleLabel)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
            
            titleLabels.append(titleLabel)
        }
        
        var labelW : CGFloat = bounds.width / CGFloat(titleLabels.count)
        let labelH : CGFloat = titleStyle.titleViewHeight
        var labelX : CGFloat = 0
        let labelY : CGFloat = 0
        
        for (i,titleLabel) in titleLabels.enumerated(){
            if titleStyle.isScrollEnable{
                //可以滚动
                let size = CGSize(width: CGFloat(MAXFLOAT), height: 0)
                let attributes = [kCTFontAttributeName : titleStyle.titleFont]
                labelW =  (titleLabel.text! as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as [NSAttributedStringKey : Any], context: nil).width
                labelX = ( i==0 ? titleStyle.titleMargin * 0.5 : (titleLabels[i-1].frame.maxX + titleStyle.titleMargin ))
            }else{
                //不可以滚动 平分
                labelX = labelW * CGFloat(i)
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        
        if titleStyle.isScrollEnable{
            scrollView.contentSize = CGSize(width: (titleLabels.last?.frame.maxX)! + titleStyle.titleMargin * 0.5, height: 0)
        }
        
        if titleStyle.isNeedTitleScale{
            titleLabels.first?.transform = CGAffineTransform(scaleX: titleStyle.scaleRange, y: titleStyle.scaleRange)
        }
    }
}

extension TitleView{
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer){
        guard let targetLabel = tapGes.view as? UILabel else{
            return
        }
        
        guard targetLabel.tag != currentIndex else {
            return
        }
        
        let sourceLabel = titleLabels[currentIndex]
        sourceLabel.textColor = titleStyle.normalColor
        targetLabel.textColor = titleStyle.selectColor
        currentIndex = targetLabel.tag
        
        //调整中间位置offset
        adjustLabelPos()
        
        //MARK:delegate 3
        delegate?.titleView(self, targetIndex: currentIndex)
        
        if titleStyle.isNeedTitleScale{
            UIView.animate(withDuration: 0.5, animations: {
                sourceLabel.transform = CGAffineTransform.identity
                targetLabel.transform = CGAffineTransform(scaleX: self.titleStyle.scaleRange, y: self.titleStyle.scaleRange)
            })
        }
        
        if titleStyle.isShowBottomLine {
            //x & width    bounds是等于frame与Transform比例计算得来的，bounds不等于frame的宽高
            UIView.animate(withDuration: 0.5, animations: {
                //MARK:- 等分情况下的滚动条 2
                if !self.titleStyle.isScrollEnable{
                    self.bottomLine.frame.origin.x = targetLabel.frame.origin.x +  self.titleStyle.bottomLineExtendWidth
                    self.bottomLine.frame.size.width = targetLabel.frame.width -  2 * self.titleStyle.bottomLineExtendWidth
                }else{
                    self.bottomLine.frame.origin.x = targetLabel.frame.origin.x -  self.titleStyle.bottomLineExtendWidth
                    self.bottomLine.frame.size.width = targetLabel.frame.width +  2 * self.titleStyle.bottomLineExtendWidth
                }
            })
        }
        
        //MARK:- 可滚动不可滚动 有下划线没有下划线 共4种组合情况的处理 2
        if titleStyle.isShowCoverView{
            UIView.animate(withDuration: 0.5, animations: {
                self.coverView.frame.origin.x = self.titleStyle.isShowBottomLine ? self.bottomLine.frame.origin.x : targetLabel.frame.origin.x
                self.coverView.frame.size.width = self.titleStyle.isShowBottomLine ? self.bottomLine.frame.width : targetLabel.frame.width
                //没有滚动条且可滚动
                if !self.titleStyle.isShowBottomLine && self.titleStyle.isScrollEnable{
                    self.coverView.frame.origin.x -= self.titleStyle.coverMargin
                    self.coverView.frame.size.width += self.titleStyle.coverMargin * 2
                }
                //没有滚动条且不可滚动
                if !self.titleStyle.isShowBottomLine && !self.titleStyle.isScrollEnable{//等分
                    self.coverView.frame.origin.x += self.titleStyle.coverMargin
                    self.coverView.frame.size.width -= self.titleStyle.coverMargin * 2
                }
            })
        }
    }
    
    fileprivate func adjustLabelPos(){
        guard titleStyle.isScrollEnable else {
            return
        }
        
        let targetLabel = titleLabels[currentIndex]
        var offset = targetLabel.center.x - scrollView.frame.width * 0.5
        //        print(offset)
        if offset < 0{
            offset = 0
        }
        let maxOffset = scrollView.contentSize.width - scrollView.bounds.width
        if offset > maxOffset{
            offset = maxOffset
        }
        scrollView.setContentOffset(CGPoint(x:offset,y:0), animated: true)
    }
}

//MARK:- 代理的使用 2
extension TitleView:ContentViewDelegate{
    func contentView(_ contentView: ContentView, didEndScroll inIndex: Int) {
        currentIndex = inIndex
        //调整中间位置offset
        adjustLabelPos()
    }
    
    func contentView(_ contentView: ContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]

        
        if titleStyle.isNeedTitleScale{
            let deltaScale = titleStyle.scaleRange - 1.0
            sourceLabel.transform = CGAffineTransform(scaleX: titleStyle.scaleRange - deltaScale * progress, y: titleStyle.scaleRange - deltaScale * progress)
            targetLabel.transform = CGAffineTransform(scaleX: 1 + deltaScale * progress, y: 1 + deltaScale * progress)
        }
        
        let deltaWidth = targetLabel.frame.width - sourceLabel.frame.width
        let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        //x & width
        if titleStyle.isShowBottomLine{
            //MARK:- 等分情况下的滚动条 3
            if !titleStyle.isScrollEnable{
                bottomLine.frame.origin.x = sourceLabel.frame.origin.x + deltaX * progress +  titleStyle.bottomLineExtendWidth
                bottomLine.frame.size.width = sourceLabel.frame.width + deltaWidth * progress -  2 * titleStyle.bottomLineExtendWidth
            }else{
                bottomLine.frame.origin.x = sourceLabel.frame.origin.x + deltaX * progress -  titleStyle.bottomLineExtendWidth
                bottomLine.frame.size.width = sourceLabel.frame.width + deltaWidth * progress +  2 * titleStyle.bottomLineExtendWidth
            }
        }
        
        //MARK:- 可滚动不可滚动 有下划线没有下划线 共4种组合情况的处理 3
        if titleStyle.isShowCoverView{
            coverView.frame.origin.x = titleStyle.isShowBottomLine ? bottomLine.frame.origin.x : (sourceLabel.frame.origin.x + deltaX * progress)
            coverView.frame.size.width = titleStyle.isShowBottomLine ? bottomLine.frame.width : (sourceLabel.frame.width + deltaWidth * progress)
            //没有滚动条且可滚动
            if !titleStyle.isShowBottomLine && titleStyle.isScrollEnable{
                coverView.frame.origin.x -= titleStyle.coverMargin
                coverView.frame.size.width += titleStyle.coverMargin * 2
            }
            //没有滚动条且不可滚动
            if !titleStyle.isShowBottomLine && !titleStyle.isScrollEnable{//等分
                coverView.frame.origin.x += titleStyle.coverMargin
                coverView.frame.size.width -= titleStyle.coverMargin * 2
            }
        }
        
    }
}

