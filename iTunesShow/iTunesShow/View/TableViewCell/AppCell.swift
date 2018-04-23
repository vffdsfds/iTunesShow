//
//  TitleView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

class AppCell: BaseCell {

//    var title:UILabel!
//    var backView:UIView!
//    var iconImage:UIImageView!
    let space:Int = 5
    let width:Int = Int(pageViewFrame.width/3)

    let iconarr = NSMutableArray()
    let titlearr = NSMutableArray()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setUpUI() {
      for i in 0...3 {
       let backView = UIView()
       let iconImage = UIImageView()
       let title = UILabel()
        title.font=UIFont.boldSystemFont(ofSize: 12)
        title.numberOfLines=2

        self.addSubview(backView)
        backView.addSubview(iconImage)
        backView.addSubview(title)
        
        switch i {
        case 0:
            backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(width)
            make.bottom.equalToSuperview().offset(-5)
            }
        case 1:
            backView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(5)
                make.width.equalTo(width)
                make.bottom.equalToSuperview().offset(-5)
                make.left.equalToSuperview().offset(i*(width))
            }
        default:
            backView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(5)
                make.width.equalTo(width)
                make.bottom.equalToSuperview().offset(-5)
                make.left.equalToSuperview().offset(i*(width))
            }
        }
        iconImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(width-20)
        }
        title.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(30)
        }
        title.textAlignment = .center
        iconarr.add(iconImage)
        titlearr.add(title)
      }
    }
    override func setupShowDate(dateArr: NSMutableArray, row: NSInteger) {
        for i in 0...dateArr.count-1{
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
