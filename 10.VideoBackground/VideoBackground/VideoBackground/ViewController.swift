//
//  ViewController.swift
//  VideoBackground
//
//  Created by linsyorozuya on 2017/9/10.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit

class ViewController: VideoSplashVieViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        videoFrame = self.view.bounds
        alpha = 1.0
        alwaysRepeate = true
        startTime = 0.0
        duration = 2.0
        contentUrl = URL.init(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4" )!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

