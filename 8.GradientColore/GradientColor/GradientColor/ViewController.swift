//
//  ViewController.swift
//  GradientColor
//
//  Created by linsyorozuya on 2017/9/5.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let gradientLayer = CAGradientLayer()
    var audioplayer:AVAudioPlayer?
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL.fileURL(withPath:Bundle.main.path(forResource: "Ecstasy", ofType: "mp3")! )
        do{
            audioplayer = try AVAudioPlayer.init(contentsOf: url)
            audioplayer?.numberOfLoops = 1000
            audioplayer?.prepareToPlay()
        }catch{
            print("error")
        }
        
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [
            UIColor(white: 0.5, alpha: 0.2).cgColor as CGColor,
            UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor as CGColor,
            UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor as CGColor,
            UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor as CGColor,
            UIColor(white: 0.4, alpha: 0.2).cgColor as CGColor]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.addSublayer(gradientLayer)
    }

    @IBAction func StartPlay(_ sender: Any) {
        if audioplayer?.isPlaying == false{
            audioplayer?.play()
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
                let redValue = CGFloat(drand48())
                let blueValue =  CGFloat(drand48())
                let greenValue = CGFloat(drand48())
                self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
            })
        }else{
            audioplayer?.stop()
            timer?.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

