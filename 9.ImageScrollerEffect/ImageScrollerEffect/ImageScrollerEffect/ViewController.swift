//
//  ViewController.swift
//  ImageScrollerEffect
//
//  Created by linsyorozuya on 2017/9/7.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate{

    var scrollView : UIScrollView!
    var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = UIImageView.init(image: UIImage.init(named: "steve"))
        
        scrollView = UIScrollView.init(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        scrollView.contentSize = imageView.bounds.size
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self
        
        setZoomScale(scrollView.bounds.size)
        recenterImage()
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setZoomScale(scrollView.bounds.size)

    }
    
    func setZoomScale(_ scrollViewSize:CGSize) {
        let imageSize = imageView.bounds.size
        
        let widthScale = scrollViewSize.width/imageSize.width
        let heightScale = scrollViewSize.height/imageSize.height
        
        let minimumScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minimumScale
        scrollView.maximumZoomScale = 3
        
        if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
    }
    
    
    fileprivate func recenterImage() {
        
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        let horizontalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        let verticalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.width) / 2.0 :0
        
        scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace)
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        recenterImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

