//
//  FavoriteListViewController.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 6/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift
import UIKit
import XLPagerTabStrip

class FavoriteListViewController: UITableViewController {
    
    let vm = FavoriteListViewModel()
    fileprivate let mvm = MainViewModel()
    fileprivate let disposeBag = DisposeBag()
    var itemInfo: IndicatorInfo = "View"
    fileprivate var favoriteList: [MobilePhone] = []
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MobileCell", bundle: Bundle.main), forCellReuseIdentifier: "MobileCell")
        vm.getFavoriteList()
        vm.rx_favoriteList
            .filter { $0.count != 0 }
            .subscribe(onNext: { [unowned self] in
                self.favoriteList = $0
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MobileCell", for: indexPath) as? MobileCell else { return MobileCell() }
        cell.favoriteButton.isHidden = true
        let mobile = favoriteList[indexPath.row]
        cell.apply(mobile)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            alertRemoveFavorite(indexPath)
        }
    }
    
    fileprivate func alertRemoveFavorite(_ indexPath: IndexPath) {
        let mobile = favoriteList[indexPath.row]
        let alertController = UIAlertController(title: "Are you sure you want to delete \(mobile.name)?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.tableView.beginUpdates()
            self.vm.updateFavorite(mobile.id, isFavorite: false)
            self.favoriteList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension FavoriteListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
}
