//
//  secondVC.swift
//  Dec-14-Exam
//
//  Created by Admin on 14/12/22.
//

import UIKit

class secondVC: UIViewController {

    var delegate: DataDelegate?
    
    @IBOutlet weak var expenseType: UITextField!
    
    @IBOutlet weak var expenseDesc: UITextField!
    
    @IBOutlet weak var expenseDate: UIDatePicker!
    
    @IBOutlet weak var expenseAmount: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveDataBtn(_ sender: Any) {
        if let expType = expenseType.text,let expDesc = expenseDesc.text,let expAmount = expenseAmount.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            let x = dateFormatter.string(from: expenseDate.date)
            delegate?.updateTable(expenseType: expType, expenseDesc: expDesc, expenseDate: x, expenseAmount: expAmount)
        }
        self.dismiss(animated: true)
    }
    
    
}
