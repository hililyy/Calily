//
//  LocalDataStore.swift
//  Calily
//
//  Created by 강조은 on 2022/06/27.
//

import Foundation

class LocalDataStore {
    static let localDataStore = LocalDataStore()
    
    func getData() -> [CalcEntity] {
        guard let getData = UserDefaults.standard.value(forKey: LocalDataKeySet.CALC_DATA.rawValue) as? Data else { return [] }
        let calcData = try? PropertyListDecoder().decode (
                Array<CalcEntity>.self, from: getData
            )
        return calcData ?? []
    }
    
    func setData(newData: [CalcEntity]) {
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newData), forKey: LocalDataKeySet.CALC_DATA.rawValue)
    }
    
}
