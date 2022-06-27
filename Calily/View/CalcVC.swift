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
    @IBOutlet weak var divisionBtn: UIButton!
    @IBOutlet weak var multiBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var dotBtn: UIButton!
    @IBOutlet weak var beforeCalcTableView: UITableView!
    @IBOutlet weak var beforeCalcAllDeleteBtn: UIButton!

    let model = CalcViewModel.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        beforeCalcTableView.delegate = self
        beforeCalcTableView.dataSource = self
        resultLabel.text = "0"
        model.getBeforeCalc()
    }

    @IBAction func touchNumberBtn(_ sender: UIButton) {
        self.resultLabel.text =  model.setNumberBtnData(sender: sender)
    }
    
    @IBAction func touchOperatorBtn(_ sender: UIButton) {
        switch sender {
        case self.divisionBtn:
            model.operation(.Divide)
        case self.multiBtn:
            model.operation(.Multi)
        case self.minusBtn:
            model.operation(.Minus)
        case self.plusBtn:
            model.operation(.Plus)
        default:
            break
        }
    }
    
    @IBAction func touchDotBtn(_ sender: Any) {
        self.resultLabel.text = model.setDotBtnData()
    }
    
    @IBAction func touchResultBtn(_ sender: Any) {
        model.setResultBtnData()
        resultLabel.text = model.result
        beforeCalcTableView.reloadData()
    }
    
    @IBAction func touchClearBtn(_ sender: Any) {
        resultLabel.text = "0"
        model.dataInitialize()
    }
    
    @IBAction func deleteBeforeCalc(_ sender: Any) {
        model.deleteBeforeCalc()
        beforeCalcTableView.reloadData()
    }

}

extension CalcVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.beforeCalcList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = beforeCalcTableView.dequeueReusableCell(withIdentifier: "beforeCalcCell", for: indexPath) as! BeforeCalcTableViewCell
        cell.cellText.text = "\(model.beforeCalcList[indexPath.row].formula) = \(model.beforeCalcList[indexPath.row].result)"
        return cell
    }
}


