//
//  CalcVC.swift
//  Calily
//
//  Created by 강조은 on 2022/06/21.
//

import UIKit
enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

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

    var operatorFlag: Bool = false
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""  // 새롭게 입력된 값을 저장하는 프로퍼티
    var result = ""
    var currentOpertaion: Operation = .unknown
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
    }

    @IBAction func touchNumberBtn(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.resultLabel.text = self.displayNumber
        }
    }
    
    @IBAction func touchOperatorBtn(_ sender: Any) {
        
    }
    
    @IBAction func touchDotBtn(_ sender: Any) {
        if self.displayNumber.count < 8 , !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.resultLabel.text = self.displayNumber
        }
    }
    @IBAction func touchResultBtn(_ sender: Any) {
    }
    
    @IBAction func touchClearBtn(_ sender: Any) {
        resultLabel.text = "0"
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOpertaion = .unknown
        
    }
    
    func operation(_ operation: Operation) {
        if self.currentOpertaion != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                switch self.currentOpertaion {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand) "
                    
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                
                default:
                    break
                }
                
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                self.firstOperand = self.result
                self.resultLabel.text = self.result
            }
            
            self.currentOpertaion = operation
        } else {
            self.firstOperand = self.displayNumber
            self.currentOpertaion = operation
            self.displayNumber = ""
        }
    }
}
