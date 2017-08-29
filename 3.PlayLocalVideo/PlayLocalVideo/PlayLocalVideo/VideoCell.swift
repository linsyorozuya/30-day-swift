//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by linsyorozuya on 2017/8/29.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit

struct video {
    let image:String
    let title:String
    let source:String
}

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoScreenShot: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoSourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
