//
//  AlertController.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 7/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import UIKit

class AlertController {
    
    static let share = AlertController()
    
    func show(fromViewController: UIViewController, title: String?, message: String? = nil, onAccept: (() -> Void)? = nil) {
        guard let tt = title, !tt.isEmpty else { return }
        let alertController = UIAlertController(title: tt, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        fromViewController.present(alertController, animated: true, completion: nil)
    }
    
}
