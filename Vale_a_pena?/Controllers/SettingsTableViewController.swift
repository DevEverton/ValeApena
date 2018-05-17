//
//  SettingsTableViewController.swift
//  Vale_a_pena?
//
//  Created by Everton Carneiro on 14/05/2018.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SettingsTableViewController: UITableViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var weeklyWorkHoursLabel: UILabel!
    @IBOutlet weak var moneyPerHourLabel: UILabel!
    @IBOutlet weak var switchOut: UISwitch!
    
    var salary = Double()
    var workWeek = Double()
    var hourValue = Double()
    var isDay = Bool()
    let defaults = UserDefaults.standard
    var bannerView: GADBannerView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        bannerView = GADBannerView(adSize: kGADAdSizeMediumRectangle)
        bannerView.adUnitID = "ca-app-pub-4828696079960529/8664119628"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hourValue = calculateHourValue()
        salaryLabel.text = formatToCurrency(number: "\(defaults.double(forKey: "salary"))", withSymbol: "R$")
        weeklyWorkHoursLabel.text = "\(Int(defaults.double(forKey: "weekWorkHours")))"
        moneyPerHourLabel.text = formatToCurrency(number: "\(hourValue)", withSymbol: "R$")
        setSwitchState()
        if let indexPath = self.tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.imageView?.image = #imageLiteral(resourceName: "salary_icon")
        }
        if indexPath.row == 1 {
            cell.imageView?.image = #imageLiteral(resourceName: "week_icon")
        }
        if indexPath.row == 2 {
            cell.imageView?.image = #imageLiteral(resourceName: "hour_value_icon")
        }
        if indexPath.row == 3 {
            cell.imageView?.image = #imageLiteral(resourceName: "days_icon")
        }
        if indexPath.row == 4 {
            cell.imageView?.image = #imageLiteral(resourceName: "info_icon")
        }
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
    
    func formatToCurrency(number: String, withSymbol symbol: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.currencySymbol = symbol
        if let number2 = Double(number){
            return numberFormatter.string(from: NSNumber(value: number2))!
        }
        return number
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editS" || segue.identifier == "editW" {
            let destination = segue.destination as! EditViewController
            guard let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
            destination.rowTapped = selectedRow
        }

    }
    
    //MARK: Banner view methods
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }

    
    

}
