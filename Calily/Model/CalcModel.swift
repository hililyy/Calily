//
//  CalcModel.swift
//  Calily
//
//  Created by 강조은 on 2022/06/22.
//

import Foundation

class CalcModel {
    static let calcModel = CalcModel()
    var beforeCalcList: [CalcEntity] = []
    
    private init() {}
    
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
}


