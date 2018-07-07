//
//  MainViewController.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 5/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift
import UIKit
import XLPagerTabStrip


class MainViewController: ButtonBarPagerTabStripViewController {
    
//    let vm = MainViewModel()
    fileprivate let disposeBag = DisposeBag()
    fileprivate let mobileVC = MobileListViewController(itemInfo: "All")
    fileprivate let favoriteVC = FavoriteListViewController(itemInfo: "Favorite")
    
    @IBAction func sortList(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        let lowPriceAction = UIAlertAction(title: "Price low to high", style: .default, handler: { action in
//            MainViewModel.share.rx_sortType.onNext(SortType.lowPrice)
            MainViewModel.share.rx_sortType.onNext(SortType.lowPrice)
        })
        let highPriceAction = UIAlertAction(title: "Price high to low", style: .default, handler: { action in
            MainViewModel.share.rx_sortType.onNext(SortType.highPrice)
        })
        let ratingAction = UIAlertAction(title: "Rating", style: .default, handler: { action in
            MainViewModel.share.rx_sortType.onNext(SortType.rating)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(lowPriceAction)
        alertController.addAction(highPriceAction)
        alertController.addAction(ratingAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = UIColor.white
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.lightGray
            newCell?.label.textColor = UIColor.black
        }
        MainViewModel.share.getMobileList()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [mobileVC, favoriteVC]
    }
    
}
