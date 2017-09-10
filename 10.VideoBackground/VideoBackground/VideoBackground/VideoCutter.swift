//
//  VideoCutter.swift
//  VideoBackground
//
//  Created by linsyorozuya on 2017/9/10.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit
import AVFoundation

extension String{
    var convert : NSString { return self as NSString}
    
}

class VideoCutter: NSObject {

    func cropVideoWithUrl(videoUrl:URL, startTime:CGFloat, duration:CGFloat, complete:@escaping ((_ videoPath:URL)->Void))
    {
        DispatchQueue.global().async
        {
            let asset = AVAsset.init(url: videoUrl)
            let exportSession = AVAssetExportSession.init(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let path : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputUrl = path.object(at: 0) as! String
            let manager = FileManager.default
            do{
                try manager.createDirectory(atPath: outputUrl , withIntermediateDirectories: true, attributes: nil)
            }catch{
            }
            outputUrl = outputUrl.convert.appendingPathComponent("output.mp4")
            do{
                try manager.removeItem(atPath: outputUrl)
            }catch{
            }
            if let exportSession = exportSession as AVAssetExportSession?{
                exportSession.outputURL = URL.init(fileURLWithPath: outputUrl)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileTypeMPEG4
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
                let range = CMTimeRange.init(start: start, duration: duration)
                exportSession.timeRange = range
                exportSession.exportAsynchronously{ () -> Void in
                    switch exportSession.status{
                    case .completed:
                        complete(exportSession.outputURL!)
                    case .failed:
                        print("Failed: \(String(describing: exportSession.error))")
                    case .cancelled:
                        print("Failed: \(String(describing: exportSession.error))")
                    default:
                        print("default case")
                    }
                }
            }
        }
    }
}
