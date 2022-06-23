//
//  CalcVC.swift
//  Calily
//
//  Created by 강조은 on 2022/06/21.
//

import UIKit

class CalcVC: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var acBtn: UIButton!
    @IBOutlet weak var reversePlusMinusBtn: UIButton!
    @IBOutlet weak var percentBtn: UIButton!
    @IBOutlet weak var divisionBtn: UIButton!
    @IBOutlet weak var multiBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var dotBtn: UIButton!
    
    var firstNum: Int?
    var secondNum: Int?
    var operatorFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
    }

    @IBAction func touchNumberBtn(_ sender: Any) {
    }
    
    @IBAction func touchOperatorBtn(_ sender: Any) {
    }
    
    @IBAction func touchResultBtn(_ sender: Any) {
    }
    
    @IBAction func touchClearBtn(_ sender: Any) {
        resultLabel.text = "0"
    }
    
}
