//
//  VideoSplashVieViewController.swift
//  VideoBackground
//
//  Created by linsyorozuya on 2017/9/10.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

enum ScaleMode{
    case resize
    case resizeAspect
    case resizeAspectFill
}

class VideoSplashVieViewController: UIViewController {

    fileprivate let videoPlayer = AVPlayerViewController()
    var videoFrame : CGRect? = CGRect()
    var videoSoundLevel : Float = 1.0
    var startTime: CGFloat = 0.0
    var duration: CGFloat = 0.0
    
    var contentUrl:URL?{
        didSet{
           setMoviePlayer(contentUrl!)
        }
    }
    
    var alpha:CGFloat?{
        didSet{
           videoPlayer.view.alpha = alpha!
        }
    }
    
    var sound:Bool = true{
        didSet{
            if sound == true {
                videoSoundLevel = 1.0
            }else{
                videoSoundLevel = 0.0
            }
        }
    }
    
    var alwaysRepeate : Bool = true{
        didSet{
            if alwaysRepeate {
                NotificationCenter.default.addObserver(self, selector: #selector(VideoSplashVieViewController.playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer.player?.currentItem)
            }
        }
    }
    
    var fillMode : ScaleMode = .resizeAspectFill{
        didSet{
            switch fillMode {
            case .resize:
                videoPlayer.videoGravity = AVLayerVideoGravityResize
            case .resizeAspect:
                videoPlayer.videoGravity = AVLayerVideoGravityResizeAspect
            case .resizeAspectFill:
                videoPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer.view.frame = videoFrame!
        videoPlayer.showsPlaybackControls = false
        self.view.addSubview(videoPlayer.view)
        self.view.sendSubview(toBack: videoPlayer.view)
    }
    
    fileprivate func setMoviePlayer(_ url:URL){
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath) in
            if (videoPath as URL?) != nil {
                self.videoPlayer.player = AVPlayer.init(url: videoPath)
                self.videoPlayer.player?.play()
                self.videoPlayer.player?.volume = self.videoSoundLevel
            }
        }
    }
    
    func playerItemDidReachEnd() {
        videoPlayer.player?.seek(to: kCMTimeZero)
        videoPlayer.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
