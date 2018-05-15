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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let salaryString = salaryTextField.text else {return}
        guard let weekWorkHoursString = weeklyWorkHoursTextField.text else {return}
        let newSalaryString = salaryString.replacingOccurrences(of: ",", with: ".")
        guard let salary = Double(newSalaryString), let weekWorkHours = Double(weekWorkHoursString)  else {return}
        
        settingUserDefaults(salary: salary, weekWorkHours: weekWorkHours)
        salaryTextField.resignFirstResponder()
        weeklyWorkHoursTextField.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)

    }
    
    func settingUserDefaults(salary: Double, weekWorkHours: Double) {
        defaults.set(salary, forKey: "salary")
        defaults.set(weekWorkHours, forKey: "weekWorkHours")
        
    }
    

}
