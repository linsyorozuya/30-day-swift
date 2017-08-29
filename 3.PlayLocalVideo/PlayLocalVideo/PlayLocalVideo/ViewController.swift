//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by linsyorozuya on 2017/8/29.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit
import AVKit
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var data = [
        video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        video(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        video(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
    ]
    
    var avPlayerVC = AVPlayerViewController()
    var avPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:VideoCell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.videoScreenShot.image = UIImage.init(named: data[indexPath.row].image)
        cell.videoTitleLabel.text = data[indexPath.row].title
        cell.videoSourceLabel.text = data[indexPath.row].source
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        avPlayer = AVPlayer(url: URL.init(fileURLWithPath: path!))
        avPlayerVC.player = avPlayer
        self.present(avPlayerVC, animated: true) {
            self.avPlayerVC.player?.play()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

