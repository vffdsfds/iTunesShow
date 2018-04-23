//
//  TitleView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
   
    var _imageView:UIImageView = UIImageView()
    let label = UILabel()

    var imageScaleBlock: ((_ scale:CGFloat, _ index:NSInteger) -> ())?
    var scale :CGFloat = 0.0
    func InitImageView(dateArr: NSMutableArray,index:NSInteger){
        
     let model:Model = dateArr[0] as! Model
   
            _imageView.sd_setImage(with: URL(string: model.iconurl ), placeholderImage: UIImage(named: "placeholder.png"))
           label.text=model.titleText
        self.addSubview(_imageView)
    }

     func setUI() {
        _imageView.frame = CGRect.init(x: 0, y: 0, width: self.layer.bounds.size.width, height: self.layer.bounds.size.height)
        label.font=UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines=2
        let coverView = UIView()
        _imageView.addSubview(coverView)
        coverView.addSubview(label)
        coverView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        label.textAlignment = .center
        label.textColor = .white
        coverView.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.5)
        
        
        

    }
}
