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
    
    override func viewWillAppear(_ animated: Bool) {
        salaryTextField.text = "\(defaults.double(forKey: "salary"))"
        weeklyWorkHoursTextField.text = "\(defaults.double(forKey: "weekWorkHours"))"
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
        guard let salary = Double(newSalaryString)?.rounded(toPlaces: 2), let weekWorkHours = Double(weekWorkHoursString)?.rounded(toPlaces: 2)  else {return}
        
        guard salary < 999999.99 else {
            createAlert(withTitle: "ERRO", message: "Valor inválido. Insira um valor abaixo de 999999,99.", actionTitle: "OK")
            return
        }
        guard weekWorkHours < 168.0 else {
            createAlert(withTitle: "ERRO", message: "Valor inválido. Insira um valor abaixo de 168.", actionTitle: "OK")
            return
        }
        
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
