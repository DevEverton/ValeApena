//
//  EditViewController.swift
//  Vale_a_pena?
//
//  Created by Everton Carneiro on 14/05/2018.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var weeklyWorkHoursTextField: UITextField!
    
    let defaults = UserDefaults.standard

    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    func settingUserDefaults() {
        
    }
    

}
