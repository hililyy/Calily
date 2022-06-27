//
//  CalcModel.swift
//  Calily
//
//  Created by 강조은 on 2022/06/22.
//

import Foundation
import UIKit

class CalcModel {
    static let model = CalcModel()
    var beforeCalcList: [CalcEntity] = []
    var operatorFlag: Bool = false
    var displayNumber: String = ""
    var firstOperand = ""
    var secondOperand = ""
    var result: String = ""
    var formula: String = ""
    var currentOpertaion: Operation = .unknown
    var firstOperandData: Int = 0
    var secondOperandData: Int = 0
    private init() {}
}
extension CalcModel: CalcOperation {
    func operation(_ operation: Operation) {
        if self.currentOpertaion != .unknown {
            if !self.displayNumber.isEmpty {
                setDisplayNumber(isCalcBefore: true)
                changeDataType()
                setResultText()
                self.setBeforeCalc(formula: formula, result: result)
            
                self.firstOperand = self.result
            }
            self.currentOpertaion = operation
        } else {
            setDisplayNumber(isCalcBefore: false)
            self.currentOpertaion = operation
        }
    }
    
    func setDisplayNumber(isCalcBefore: Bool) {
        if isCalcBefore == false {
            self.firstOperand = self.displayNumber
            self.displayNumber = ""
        } else {
            self.secondOperand = self.displayNumber
            self.displayNumber = ""
        }
    }
    
    func changeDataType() {
        guard let firstOperand = Double(self.firstOperand) else { return }
        guard let secondOperand = Double(self.secondOperand) else { return }
        self.firstOperandData = firstOperand.truncatingRemainder(dividingBy: 1.0) == 0 ? 1 : 0 // true: int, flase: double
        secondOperandData = secondOperand.truncatingRemainder(dividingBy: 1.0) == 0 ? 1 : 0
        
        if firstOperandData == 1 {
            firstOperandData = Int(firstOperand)
        }
        if secondOperandData == 1 {
            secondOperandData = Int(secondOperand)
        }
    }
    
    func setResultText() {
        guard let firstOperand = Double(self.firstOperand) else { return }
        guard let secondOperand = Double(self.secondOperand) else { return }
        
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
    }
}
extension CalcModel: StorageData {
    func setBeforeCalc(formula: String, result: String) {
        
        let newData = CalcEntity(formula: formula, result: result)
        
        beforeCalcList.append(newData)
        LocalDataStore.localDataStore.setData(newData: beforeCalcList)
    }
    
    func getBeforeCalc() {
        if LocalDataStore.localDataStore.getData().count != 0 {
            for count in 0...LocalDataStore.localDataStore.getData().count-1 {
                let entity = LocalDataStore.localDataStore.getData()[count]
                beforeCalcList.append(entity)
            }
        }
    }
    
    func deleteBeforeCalc() {
        beforeCalcList = []
        LocalDataStore.localDataStore.setData(newData: beforeCalcList)
    }
    
    func dataInitialize() {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOpertaion = .unknown
    }
}

extension CalcModel: CalcData {
    func setNumberBtnData(sender: UIButton) -> String {
        guard let numberValue = sender.titleLabel?.text else { return ""}
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            return self.displayNumber
        }
        return ""
    }
    
    func setDotBtnData() -> String {
        if self.displayNumber.count < 8 , !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            return self.displayNumber
        }
        return ""
    }
    
    func setResultBtnData() {
        self.operation(self.currentOpertaion)
    }
}
