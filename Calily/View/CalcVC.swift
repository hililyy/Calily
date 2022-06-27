//
//  CalcVC.swift
//  Calily
//
//  Created by 강조은 on 2022/06/21.
//

import UIKit
enum Operation {
    case Plus
    case Minus
    case Divide
    case Multi
    case unknown
}

class CalcVC: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var acBtn: UIButton!
    @IBOutlet weak var divisionBtn: UIButton!
    @IBOutlet weak var multiBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var dotBtn: UIButton!
    @IBOutlet weak var beforeCalcTableView: UITableView!
    @IBOutlet weak var beforeCalcAllDeleteBtn: UIButton!
    
    var operatorFlag: Bool = false
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var formula = ""
    var currentOpertaion: Operation = .unknown
    let calcModel = CalcModel.calcModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
        beforeCalcTableView.delegate = self
        beforeCalcTableView.dataSource = self
        calcModel.getBeforeCalc()
    }

    @IBAction func touchNumberBtn(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.resultLabel.text = self.displayNumber
        }
    }
    
    @IBAction func touchOperatorBtn(_ sender: UIButton) {
        switch sender {
        case self.divisionBtn:
            self.operation(.Divide)
        case self.multiBtn:
            self.operation(.Multi)
        case self.minusBtn:
            self.operation(.Minus)
        case self.plusBtn:
            self.operation(.Plus)
        default:
            break
        }
    }
    
    @IBAction func touchDotBtn(_ sender: Any) {
        if self.displayNumber.count < 8 , !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.resultLabel.text = self.displayNumber
        }
    }
    
    @IBAction func touchResultBtn(_ sender: Any) {
        self.operation(self.currentOpertaion)
        beforeCalcTableView.reloadData()
    }
    
    @IBAction func touchClearBtn(_ sender: Any) {
        resultLabel.text = "0"
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOpertaion = .unknown
    }
    
    @IBAction func deleteBeforeCalc(_ sender: Any) {
        calcModel.deleteBeforeCalc()
        beforeCalcTableView.reloadData()
    }
    func operation(_ operation: Operation) {
        if self.currentOpertaion != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                var firstOperandData = firstOperand.truncatingRemainder(dividingBy: 1.0) == 0 ? 1 : 0 // true: int, flase: double
                var secondOperandData = secondOperand.truncatingRemainder(dividingBy: 1.0) == 0 ? 1 : 0
                
                if firstOperandData == 1 {
                    firstOperandData = Int(firstOperand)
                }
                if secondOperandData == 1 {
                    secondOperandData = Int(secondOperand)
                }
                switch self.currentOpertaion {
                case .Plus:
                    self.result = "\(firstOperand + secondOperand)"
                    formula = "\(firstOperandData) + \(secondOperandData)"
                case .Minus:
                    self.result = "\(firstOperand - secondOperand) "
                    formula = "\(firstOperandData) - \(secondOperandData)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    formula = "\(firstOperandData) / \(secondOperandData)"
                case .Multi:
                    self.result = "\(firstOperand * secondOperand)"
                    formula = "\(firstOperandData) * \(secondOperandData)"
                default:
                    break
                }
                
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                calcModel.setBeforeCalc(formula: formula, result: result)
                
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

extension CalcVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcModel.beforeCalcList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = beforeCalcTableView.dequeueReusableCell(withIdentifier: "beforeCalcCell", for: indexPath) as! BeforeCalcTableViewCell
        cell.cellText.text = "\(calcModel.beforeCalcList[indexPath.row].formula) = \(calcModel.beforeCalcList[indexPath.row].result)"
        return cell
    }
}


