//
//  ViewController.swift
//  SimpleStopWatch
//
//  Created by linsyorozuya on 2017/8/28.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer:Timer?
    var count = 0.0
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel.text = "0.0"
    }
    
    func animation(isStart start:Bool){
        UIView.animate(withDuration: 0.2) {
            self.startBtn.isHidden = start;
            self.stopBtn.isHidden = !start;
        }
    }
    
    @IBAction func startTimeEvent(_ sender: Any) {
        startBtn.isEnabled = false
        stopBtn.isEnabled = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [unowned self] (timer) in
            self.count += 0.1
            self.timeLabel.text = String(self.count)
        })
        animation(isStart: true)
    }

    @IBAction func stopTimeEvent(_ sender: Any) {
        startBtn.isEnabled = true
        stopBtn.isEnabled = false
        timer?.invalidate()
        animation(isStart: false)
    }
    
    @IBAction func resetTimeEvent(_ sender: Any) {
        startBtn.isEnabled = true
        stopBtn.isEnabled = true
        timer?.invalidate()
        count = 0.0
        timeLabel.text = "0.0"
        animation(isStart: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("done")
    }
}

