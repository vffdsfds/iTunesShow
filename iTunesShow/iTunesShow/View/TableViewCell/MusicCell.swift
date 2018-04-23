//
//  TitleView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

class MusicCell: BaseCell {

//    var label:UILabel!
//    var iconImage:UIImageView!
//    var coverView:UIView!
    let iconarr = NSMutableArray()
    let titlearr = NSMutableArray()
    
    let space:Int = 5
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
      override func setUpUI() {
        
        for i in 0...1 {
           let label = UILabel()
            label.font=UIFont.boldSystemFont(ofSize: 12)
            label.numberOfLines=2
            let iconImage = UIImageView()
           let coverView = UIView()
            self.addSubview(iconImage)
            iconImage.addSubview(coverView)
            coverView.addSubview(label)
            switch i {
                case 0 :
                   iconImage.snp.makeConstraints { (make) in
                      make.top.equalToSuperview().offset(5)
                      make.width.height.equalTo(pageViewFrame.width/2-10)
                    print("frame\(pageViewFrame.width)")
                      make.left.equalToSuperview().offset(space)
                   }
                default :
                    iconImage.snp.makeConstraints { (make) in
                        make.top.equalToSuperview().offset(5)
                        make.width.height.equalTo(pageViewFrame.width/2-10)
                        make.right.equalToSuperview().offset(-space)
                }
            }
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
            iconarr.add(iconImage)
            titlearr.add(label)
        }
    }
    override func setupShowDate(dateArr:NSMutableArray , row:NSInteger){
        for i in 0...dateArr.count-1 {
            let icon = iconarr[i]
            let title = titlearr[i]
            let model:Model = dateArr[i] as! Model
            (icon as! UIImageView).sd_setImage(with: URL(string: model.iconurl ), placeholderImage: UIImage(named: "placeholder.png"))
            (title as! UILabel).text = model.titleText
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
