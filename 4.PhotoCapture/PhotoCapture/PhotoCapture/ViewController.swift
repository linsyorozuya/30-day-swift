//
//  ViewController.swift
//  PhotoCapture
//
//  Created by linsyorozuya on 2017/8/30.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var outPutImage: UIImageView!
    
    var captureSession:AVCaptureSession?
    var captureOutput:AVCapturePhotoOutput?
    var previewLayer:AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        previewLayer?.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        var input:AVCaptureDeviceInput!
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        var error : NSError?
        
        do {
            if backCamera != nil {
                input = try AVCaptureDeviceInput(device: backCamera!)
            }else{
                error = NSError()
            }
        }
        catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if (error == nil && captureSession?.canAddInput(input) != nil) {
            captureSession?.addInput(input)
            captureOutput = AVCapturePhotoOutput()
            
            if (captureSession?.canAddOutput(captureOutput!) != nil) {
                captureSession?.addOutput(captureOutput!)
                captureSession?.startRunning()
                
                let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession!)
                captureVideoLayer.frame = self.outPutImage.bounds
                captureVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.outPutImage.layer.addSublayer(captureVideoLayer)
            }
        }
    }
    
    @IBOutlet weak var stakeView: UIStackView!
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let photoSampleBuffer = photoSampleBuffer {
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            let image = UIImage(data: photoData!)
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFit
            self.stakeView.addArrangedSubview(imageView)
            UIView.animate(withDuration: 0.2, animations: {
                self.stakeView.layoutIfNeeded()
            })
            //            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
        
    }
    
    
    @IBAction func takePhoto(_ sender: Any) {
        let setting = AVCapturePhotoSettings()
        setting.flashMode = .off
        setting.isAutoStillImageStabilizationEnabled = true
        setting.isHighResolutionPhotoEnabled = false
        captureOutput?.capturePhoto(with: setting, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

