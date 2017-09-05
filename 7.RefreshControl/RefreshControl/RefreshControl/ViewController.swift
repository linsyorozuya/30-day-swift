//
//  ViewController.swift
//  RefreshControl
//
//  Created by linsyorozuya on 2017/9/5.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var data = ["1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refreshCotrol = UIRefreshControl.init()
        refreshCotrol.attributedTitle = NSAttributedString.init(string: "Refresh")
        refreshCotrol.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshCotrol.backgroundColor = UIColor.black
        self.tableView.refreshControl = refreshCotrol
    }
    
    @objc func refresh()
    {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2) {
            self.data.append("2")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

