//
//  CalculateViewController.swift
//  Vale_a_pena?
//
//  Created by Everton Carneiro on 14/05/2018.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CalculateViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var daysOrHoursLabel: UILabel!
    
    let defaults = UserDefaults.standard
    var bannerView: GADBannerView!

    
    var resultInDays = Double()
    var resultInHours = Double()
    var isDays = Bool()
    var timer = Timer()
    var counter = 0.0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultView.alpha = 0.0
        bannerView = GADBannerView(adSize: kGADAdSizeLargeBanner)
        bannerView.adUnitID = "ca-app-pub-4828696079960529/8664119628"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self

        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        priceTextField.becomeFirstResponder()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        resultView.alpha = 0.0
        priceTextField.text = ""
    }
    
    func getPrice() -> Double {
        guard let priceString = priceTextField.text else {return 0.0}
        let newPriceString = priceString.replacingOccurrences(of: ",", with: ".")
        guard let price = Double(newPriceString) else {return 0.0}
        guard price < 10000000000 else {
            createAlert(withTitle: "ERRO", message: "Valor muito alto. Insira valor menor.", actionTitle: "OK")
            return 0.0
        }
        return price.rounded(toPlaces: 2)

    }
    
    func resultHours(price: Double, hourValue: Double) -> Double {
        return (price/hourValue).rounded(toPlaces: 2)
        
    }
    
    func resultDays(price: Double, salary: Double) -> Double {
        return ((25*price)/salary).rounded(toPlaces: 2)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: (#selector(CalculateViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        if isDays {
            daysOrHoursLabel.text = "Dias"
            if counter < resultInDays {
                hoursLabel.text = "\(counter.rounded(toPlaces: 2))".replacingOccurrences(of: ".", with: ",")
            }else if counter == resultInDays {
                counter = 0
                timer.invalidate()
            }
            counter += 0.1
        }else {
            daysOrHoursLabel.text = "Horas"
            if counter < resultInHours {
                hoursLabel.text = "\(counter.rounded(toPlaces: 2))".replacingOccurrences(of: ".", with: ",")
            }else if counter == resultInDays {
                counter = 0
                timer.invalidate()
            }
            counter += 0.1
        }
        
    }

    @IBAction func calculateButtonTapped(_ sender: Any) {
        resultInDays = resultDays(price: getPrice(), salary: defaults.double(forKey: "salary"))
        resultInHours = resultHours(price: getPrice(), hourValue: defaults.double(forKey: "hourValue"))
        isDays = defaults.bool(forKey: "isDay")
        
        priceTextField.resignFirstResponder()
        UIView.animate(withDuration: 1.0) {
            self.resultView.alpha = 1.0
        }
        counter = 0.0
        runTimer()
        
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
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("THE ERROR IS: \(error)")
    }

    

}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



