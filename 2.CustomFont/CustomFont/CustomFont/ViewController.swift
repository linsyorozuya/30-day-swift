//
//  ViewController.swift
//  CustomFont
//
//  Created by linsyorozuya on 2017/8/28.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    var data : Array<String> = ["30 days swift","practice swift code","keep on"]
    var fontNames : Array<String> = ["MFZhiHei_Noncommercial-Regular","MFTongXin_Noncommercial-Regular","MFJinHei_Noncommercial-Regular"]
    var fontIndex = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.titleLabel?.font = UIFont.init(name: self.fontNames[fontIndex], size: 16.0)
        button.setTitle("ChangeFont\n\n\(self.fontNames[fontIndex])", for: UIControlState.normal)
    }
 
    @IBAction func changeFontEvent(_ sender: Any) {
        fontIndex = Int(arc4random()%3)
        tableView.reloadData()
        button.titleLabel?.font = UIFont.init(name: self.fontNames[fontIndex], size: 16.0)
        button.setTitle("ChangeFont\n\n\(self.fontNames[fontIndex])", for: UIControlState.normal)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name:self.fontNames[fontIndex], size:16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

