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
    
    var resultInDays = 0
    var resultInHours = 0
    var isDays = Bool()
    var timer = Timer()
    
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
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: (#selector(CalculateViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        
    }

    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        priceTextField.resignFirstResponder()
        UIView.animate(withDuration: 1.0) {
            self.resultView.alpha = 1.0
        }
        
        
    }
    

}
