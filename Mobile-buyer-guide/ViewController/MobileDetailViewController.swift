//
//  MobileDetailViewController.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 7/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift
import UIKit

class MobileDetailViewController: UIViewController {
    
    var vm = MobileDetailViewModel()
    fileprivate let disposeBag = DisposeBag()
    fileprivate var mobile: MobilePhone!
    fileprivate var mobileImagesUrl: [String] = []
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.rx_mobile
            .filter { $0 != nil }
            .map { $0! }
            .subscribe(onNext: { [unowned self] in
                self.mobile = $0
                self.displayMobile()
                self.vm.getMobileImages($0.id)
            }).disposed(by: disposeBag)
        vm.rx_mobileImagesUrl
            .filter { $0.count != 0 }
            .subscribe(onNext: { [unowned self] in
                self.mobileImagesUrl = $0
                self.imageCollectionView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func displayMobile() {
        navigationItem.title = mobile.name
        priceLabel.text = "Price: \(mobile.price)"
        ratingLabel.text = "Rating: \(mobile.rating)"
        descLabel.text = mobile.desc
    }
    
}

//extension MobileDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//}
