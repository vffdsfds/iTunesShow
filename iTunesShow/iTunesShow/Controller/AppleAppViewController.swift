//
//  TitleView.swift
//  iTunesShow
//
//  Created by Xin Chen on 2018/4/23.
//  Copyright © 2018年 Xin Chen. All rights reserved.
//

import UIKit

let appCellId:String = "appCellId"

class AppleAppViewController: BaseTableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AppCell.self, forCellReuseIdentifier: appCellId)
    }
    override func loadingDate() {
        Model.getAppItemArrayModel { (marray) in
            self.array.addObjects(from: marray as! [Any])

            self.tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: appCellId, for: indexPath)as! AppCell
        cell.setupShowDate(dateArr: array[indexPath.row] as! NSMutableArray, row: indexPath.row)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return pageViewFrame.width/3+30
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
