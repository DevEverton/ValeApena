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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        salaryLabel.text = "RS2000,00"
        weeklyWorkHoursLabel.text = "44"
        moneyPerHourLabel.text = "R$9,09"

    }

}
