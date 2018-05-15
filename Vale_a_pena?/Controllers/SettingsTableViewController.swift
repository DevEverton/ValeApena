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
    @IBOutlet weak var switchOut: UISwitch!
    
    var salary = Double()
    var workWeek = Double()
    var hourValue = Double()
    var isDay = Bool()
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        hourValue = calculateHourValue()
        salaryLabel.text = "R$ \(defaults.double(forKey: "salary"))"
        weeklyWorkHoursLabel.text = "\(Int(defaults.double(forKey: "weekWorkHours")))"
        moneyPerHourLabel.text = "R$ \(hourValue)"
        setSwitchState()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    
    func setSwitchState() {
        if defaults.bool(forKey: "isDay") == true {
            isDay = true
            switchOut.isOn = true
        } else {
            isDay = false
            switchOut.isOn = false
        }
    }
    
    func calculateHourValue() -> Double {
        let hourValue = (defaults.double(forKey: "salary")/(defaults.double(forKey: "weekWorkHours")*5).rounded(toPlaces: 2)).rounded(toPlaces: 2)
        defaults.set(hourValue, forKey: "hourValue")
        return defaults.double(forKey: "hourValue")
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
    
    

}
