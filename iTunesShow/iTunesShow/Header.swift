//
//  Header.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import Foundation
import UIKit

import SDWebImage
import SnapKit
import Alamofire

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGH = UIScreen.main.bounds.size.height

let musicUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/50/explicit.json"
let appUrl = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
let bookUr = "https://rss.itunes.apple.com/api/v1/us/books/top-free/all/50/explicit.json"
