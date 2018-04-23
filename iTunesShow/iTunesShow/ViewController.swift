//
//  ViewController.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit
var pageViewFrame = CGRect()
var pageView:PageView!=nil

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false//不要调整SV内边距
        self.navigationController?.navigationBar.barTintColor = UIColor.purple
        self.navigationController?.navigationBar.backgroundColor = UIColor.purple
        self.title = "iTunes"
        view?.backgroundColor=UIColor.white
        
        pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64 )//非scrollView设置64
        
        
        let titles = ["Apple Music","iOS Apps","Books"]
        let style = PageStyle()
        
        var childVCs = [UIViewController]()
        for title in titles {
            switch title {
            case "Apple Music":
                let mvc = AppleMusicViewController()
                childVCs.append(mvc)
                
            case "iOS Apps":
                let avc = AppleAppViewController()
                childVCs.append(avc)
            case "Books":
                let bvc = BooksViewController()
                childVCs.append(bvc)
            default:
                break
            }
            
        }
        
        
        
        
        pageView = PageView(frame: pageViewFrame, titles: titles, titleStyle: style, childVCs: childVCs, parentVC: self)
        view.addSubview(pageView)

        //添加通知，监听设备方向改变
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation),
                                               name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait, UIInterfaceOrientationMask.landscapeLeft]
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func receivedRotation(){
        let device = UIDevice.current
        switch device.orientation{
        case .portrait:
            //  print(1)
            pageView.removeFromSuperview()
            let titles = ["Apple Music","iOS Apps","Books"]
            let style = PageStyle()
            
            var childVCs = [UIViewController]()
            for title in titles {
                switch title {
                case "Apple Music":
                    let mvc = AppleMusicViewController()
                    childVCs.append(mvc)
                    
                case "iOS Apps":
                    let avc = AppleAppViewController()
                    childVCs.append(avc)
                case "Books":
                    let bvc = BooksViewController()
                    childVCs.append(bvc)
                default:
                    break
                }
                
            }
            
            pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height  )//非scrollView设置64
            
            
            pageView = PageView(frame: pageViewFrame, titles: titles, titleStyle: style, childVCs: childVCs, parentVC: self)
            
            view.addSubview(pageView)
        case .landscapeLeft:
            //   print(2)
            
            pageView.removeFromSuperview()
            let titles = ["Apple Music","iOS Apps","Books"]
            let style = PageStyle()
            
            var childVCs = [UIViewController]()
            for title in titles {
                switch title {
                case "Apple Music":
                    let mvc = AppleMusicViewController()
                    childVCs.append(mvc)
                    
                case "iOS Apps":
                    let avc = AppleAppViewController()
                    childVCs.append(avc)
                case "Books":
                    let bvc = BooksViewController()
                    childVCs.append(bvc)
                default:
                    break
                }
                
            }
            
            pageViewFrame = CGRect(x: 0, y: 30, width: view.bounds.width, height: view.bounds.width  )//非scrollView设置64
            
            
            pageView = PageView(frame: pageViewFrame, titles: titles, titleStyle: style, childVCs: childVCs, parentVC: self)
            
            view.addSubview(pageView)
        case .landscapeRight:
            //   print(3)
            pageView.removeFromSuperview()
            let titles = ["Apple Music","iOS Apps","Books"]
            let style = PageStyle()
            
            var childVCs = [UIViewController]()
            for title in titles {
                switch title {
                case "Apple Music":
                    let mvc = AppleMusicViewController()
                    childVCs.append(mvc)
                    
                case "iOS Apps":
                    let avc = AppleAppViewController()
                    childVCs.append(avc)
                case "Books":
                    let bvc = BooksViewController()
                    childVCs.append(bvc)
                default:
                    break
                }
                
            }
            
            pageViewFrame = CGRect(x: 0, y: 30, width: view.bounds.width, height: view.bounds.width  )//非scrollView设置64
            
            
            pageView = PageView(frame: pageViewFrame, titles: titles, titleStyle: style, childVCs: childVCs, parentVC: self)
            
            view.addSubview(pageView)
            
        default:
            pageView.removeFromSuperview()
            let titles = ["Apple Music","iOS Apps","Books"]
            let style = PageStyle()
            
            var childVCs = [UIViewController]()
            for title in titles {
                switch title {
                case "Apple Music":
                    let mvc = AppleMusicViewController()
                    childVCs.append(mvc)
                    
                case "iOS Apps":
                    let avc = AppleAppViewController()
                    childVCs.append(avc)
                case "Books":
                    let bvc = BooksViewController()
                    childVCs.append(bvc)
                default:
                    break
                }
                
            }
            
            pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height  )//非scrollView设置64
            
            
            pageView = PageView(frame: pageViewFrame, titles: titles, titleStyle: style, childVCs: childVCs, parentVC: self)
            
            view.addSubview(pageView)
            break
        }
        
    }
    
}

