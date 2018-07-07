//
//  MobileCell.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 6/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import SDWebImage
import UIKit

class MobileCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var mobileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func apply(_ mobile: MobilePhone) {
        if let imgUrl = mobile.thumbImageUrl, let url = URL(string: imgUrl) {
            mobileImgView.sd_setImage(with: url, completed: nil)
            mobileImgView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
            mobileImgView.contentMode = .scaleAspectFill
            mobileImgView.clipsToBounds = true
        }
        nameLabel.text = mobile.name
        descLabel.text = mobile.desc
        priceLabel.text = "Price: $\(mobile.price)"
        ratingLabel.text = "Rating: \(mobile.rating)"
        if mobile.isFavorite {
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
    }
    
}
