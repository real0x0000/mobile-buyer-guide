//
//  MobileImageCell.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 8/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import SDWebImage
import UIKit

class MobileImageCell: UICollectionViewCell {
    
    @IBOutlet weak var mobileImageView: UIImageView!
    
    func apply(_ imageUrl: String) {
        if let url = URL(string: imageUrl) {
            mobileImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
