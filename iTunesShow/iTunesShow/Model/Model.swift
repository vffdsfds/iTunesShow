//
//  TitleView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit
import Alamofire
typealias callBack = (_ marray:NSMutableArray) ->Void
class Model: NSObject {
    var titleText = String()
    var iconurl = String()
    
    static func getMusicItemArrayModel(callback:@escaping callBack){
        Alamofire.request(musicUrl).responseJSON { response in
            response.result.ifSuccess({
                let marr = NSMutableArray()
                var eachArr:NSMutableArray!
                let dic = response.result.value
                var array = NSArray()
                array = ((dic as! NSDictionary)["feed"]as!NSDictionary)["results"] as! NSArray
                for i in 0...array.count-1{
                    let eachDic:NSDictionary = array[i] as! NSDictionary
                    let model = Model()
                    model.titleText = eachDic["name"] as! String
                    model.iconurl = eachDic["artworkUrl100"] as! String
                    if i%2 == 0{
                      eachArr = NSMutableArray()
                        eachArr.add(model)
                    }else{
                        eachArr.add(model)
                        marr.add(eachArr)
                    }
                }
                callback(marr)
            })
        }
    }
    static func getAppItemArrayModel(callback:@escaping callBack){
        Alamofire.request(appUrl).responseJSON { response in
            response.result.ifSuccess({
                let marr = NSMutableArray()
                var eachArr:NSMutableArray!
                let dic = response.result.value
                var array = NSArray()
                array = ((dic as! NSDictionary)["feed"]as!NSDictionary)["results"] as! NSArray
                for i in 0...array.count-1{
                    let eachDic:NSDictionary = array[i] as! NSDictionary
                    let model = Model()
                    model.titleText = eachDic["name"] as! String
                    model.iconurl = eachDic["artworkUrl100"] as! String
                    if (i%3 == 0){
                        eachArr = NSMutableArray()
                        eachArr.add(model)
                    }else if (i%3==2){
                        eachArr.add(model)
                        marr.add(eachArr)
                    }else{
                        eachArr.add(model)
                    }
                }
                callback(marr)
            })
        }
    }
    static func getBooksItemArrayModel(callback:@escaping callBack){
        Alamofire.request(bookUr).responseJSON { response in
            response.result.ifSuccess({
                let marr = NSMutableArray()
                var eachArr:NSMutableArray!
                let dic = response.result.value
                var array = NSArray()
                array = ((dic as! NSDictionary)["feed"]as!NSDictionary)["results"] as! NSArray
                for i in 0...array.count-1{
                    let eachDic:NSDictionary = array[i] as! NSDictionary
                    let model = Model()
                    model.titleText = eachDic["name"] as! String
                    model.iconurl = eachDic["artworkUrl100"] as! String
                    eachArr = NSMutableArray()
                    eachArr.add(model)
                    marr.add(eachArr)
                }
                callback(marr)
            })
        }
    }

}
