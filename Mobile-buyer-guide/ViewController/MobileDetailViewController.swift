//
//  MobileDetailViewController.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 7/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import UIKit

class MobileDetailViewController: UIViewController {
    
    var mobile: MobilePhone?
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mb = mobile {
            navigationItem.title = mb.name
            priceLabel.text = "Price: \(mb.price)"
            ratingLabel.text = "Rating: \(mb.rating)"
            descLabel.text = mb.desc
        }
    }
    
}
