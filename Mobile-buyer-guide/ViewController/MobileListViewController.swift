//
//  MobileListViewController.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 6/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift
import UIKit
import XLPagerTabStrip

class MobileListViewController: UITableViewController {
    
    let vm = MobileListViewModel()
    fileprivate let disposeBag = DisposeBag()
    var itemInfo: IndicatorInfo = "View"
    fileprivate var mobileList: [MobilePhone] = []
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(MobileListViewController.updateList(_:)), name: .removeFavorite, object: nil)
        tableView.register(UINib(nibName: "MobileCell", bundle: Bundle.main), forCellReuseIdentifier: "MobileCell")
        vm.getMobileList()
        vm.rx_mobileList
            .filter { $0.count != 0 }
            .subscribe(onNext: { [unowned self] in
                self.mobileList = $0
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    @objc fileprivate func updateList(_ notification: Notification) {
        vm.getMobileList()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MobileCell", for: indexPath) as? MobileCell else { return MobileCell() }
        let mobile = mobileList[indexPath.row]
        cell.apply(mobile)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(MobileListViewController.favorite(_:)), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MOBILE_DETAIL") as? MobileDetailViewController else { return }
        let mobile = mobileList[indexPath.row]
        vc.vm.applyMobile(mobile)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func favorite(_ sender: UIButton) {
        let row = sender.tag
        let mobile = mobileList[row]
        if !(mobile.isFavorite) {
            vm.updateFavorite(mobile.id, isFavorite: true)
            let indexPath = IndexPath(row: row, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
            NotificationCenter.default.post(name: .addFavorite, object: nil)
        }
    }
    
}

extension MobileListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
}
