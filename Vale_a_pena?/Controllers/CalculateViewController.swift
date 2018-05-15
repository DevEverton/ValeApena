//
//  CalculateViewController.swift
//  Vale_a_pena?
//
//  Created by Everton Carneiro on 14/05/2018.
//  Copyright © 2018 Everton. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var daysOrHoursLabel: UILabel!
    
    var resultInDays = 10.0
    var resultInHours = 10.0
    var isDays: Bool = false
    var timer = Timer()
    var counter = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.alpha = 0.0

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resultView.alpha = 0.0
        priceTextField.text = ""
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(CalculateViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        counter += 0.1
        if isDays {
            daysOrHoursLabel.text = "dias"
            if counter < resultInDays {
                hoursLabel.text = "\(counter.rounded(toPlaces: 2))"
            }else if counter == resultInDays {
                counter = 0
                timer.invalidate()
            }
        }else {
            daysOrHoursLabel.text = "horas"
            if counter < resultInHours {
                hoursLabel.text = "\(counter.rounded(toPlaces: 2))"
            }else if counter == resultInDays {
                counter = 0
                timer.invalidate()
            }
        }
        
    }

    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        priceTextField.resignFirstResponder()

        UIView.animate(withDuration: 1.0) {
            self.resultView.alpha = 1.0
        }
        counter = 0.0
        runTimer()
        
    }
    

}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



