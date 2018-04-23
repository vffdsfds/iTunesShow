//
//  TitleView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

let bookCellId:String = "bookCellId"

class BooksViewController : UIViewController {

    var array = NSMutableArray()
    var collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingData()

        view.backgroundColor = UIColor.white
        
        //布局
      //  let layout = NDCollectionView()
        
        
        //创建collectionView
//        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: pageViewFrame.width, height: SCREEN_HEIGH ), collectionViewLayout: layout)
       
       // view.addSubview(collectionView)
        
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
      
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: bookCellId)
       }
         func loadingData() {
            Model.getBooksItemArrayModel { (marray) in
                self.array.addObjects(from: marray as! [Any])
                self.collectionView.reloadData()
            }
        }

}


extension BooksViewController : UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellId, for: indexPath)as! BookCell
      //  cell.setShowDate(dateArr: array[indexPath.row] as! NSMutableArray, row: indexPath.row)
        cell.setUI()

          cell.InitImageView(dateArr: array[indexPath.row] as! NSMutableArray,index: indexPath.row)
        cell.backgroundColor = UIColor.white

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(BookCell.self, forCellReuseIdentifier: bookCellId)
//    }
//    override func loadingDate() {
//        Model.getBooksItemArrayModel { (marray) in
//            self.array.addObjects(from: marray as! [Any])
//            self.tableView.reloadData()
//        }
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return array.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: bookCellId, for: indexPath)as! BookCell
//        cell.setupShowDate(dateArr: array[indexPath.row] as! NSMutableArray, row: indexPath.row)
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return SCREEN_WIDTH
//    }
//

}

