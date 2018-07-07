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
    
    let vm = MainViewModel()
    fileprivate let disposeBag = DisposeBag()
    fileprivate let mobileVC = MobileListViewController(itemInfo: "All")
    fileprivate let favoriteVC = FavoriteListViewController(itemInfo: "Favorite")
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        vm.getMobileList()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [mobileVC, favoriteVC]
    }
    
}
