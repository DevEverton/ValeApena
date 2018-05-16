//
//  Helper.swift
//  Vale_a_pena?
//
//  Created by Everton Carneiro on 16/05/2018.
//  Copyright © 2018 Everton. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func createAlert(withTitle title: String, message: String, actionTitle: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertWithDismiss(withTitle title: String, message: String, actionTitle: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
  
    
}
