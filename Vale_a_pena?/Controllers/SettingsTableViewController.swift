//
//  SettingsTableViewController.swift
//  Vale_a_pena?
//
//  Created by Everton Carneiro on 14/05/2018.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var weeklyWorkHoursLabel: UILabel!
    @IBOutlet weak var moneyPerHourLabel: UILabel!
    
    var salary = Double()
    var workWeek = Double()
    var hourValue = Double()
    var isDay = Bool()
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultValues()
        salaryLabel.text = "RS\(defaults.double(forKey: "salary"))"
        weeklyWorkHoursLabel.text = "\(Int(defaults.double(forKey: "workWeek")))"
        moneyPerHourLabel.text = "R$9,09"

    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if sender.isOn {
            isDay = true
            defaults.set(true, forKey: "isDay")
        }else {
            isDay = false
            defaults.set(false, forKey: "isDay")
        }
 
    }
    
    func setDefaultValues() {
        let appDefaults: [String:Any] = ["isDay" : false, "salary" : 1000.0, "workWeek": 40.0]
        defaults.register(defaults: appDefaults)
    }
    

}
