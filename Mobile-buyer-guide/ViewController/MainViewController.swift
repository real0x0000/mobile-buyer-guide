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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getMobileList()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [MobileListViewController(), FavoriteListViewController()]
    }
    
}
