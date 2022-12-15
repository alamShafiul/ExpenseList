//
//  ViewController.swift
//  Dec-14-Exam
//
//  Created by Admin on 14/12/22.
//

import UIKit

protocol DataDelegate {
    var add_OR_update: Int { get }
    var data: [ExpenseList] { get set }
    var idxPath: IndexPath? { get }
    func updateTable(expenseType: String, expenseDesc: String, expenseDate: String, expenseAmount: String) -> Void
}

class FirstVC: UIViewController, DataDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var add_OR_update = 0 // 0 -> add, 1 -> update
    var idxPath: IndexPath?
    
    var data = ExpenseList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerNib = UINib(nibName: Constants.headerView, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: Constants.headerView)
    }
    
    @IBAction func addItemBtn(_ sender: Any) {
        performSegue(withIdentifier: Constants.goToNext, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.goToNext) {
            if let second = segue.destination as? secondVC {
                second.delegate = self
                if(add_OR_update == 1) {
                    second.loadViewIfNeeded()
                    second.expenseType.text = data[idxPath!.row].type
                    second.expenseDesc.text = data[idxPath!.row].desc
                    //second.expenseDate.text = data[idxPath!.row].date
                    second.expenseAmount.text = data[idxPath!.row].amount
                }
            }
        }
    }
    
    func updateTable(expenseType: String, expenseDesc: String, expenseDate: String, expenseAmount: String) {
        if(add_OR_update == 0) {
            data.append(ExpenseList(type: expenseType, desc: expenseDesc, date: expenseDate, amount: expenseAmount))
        }
        else {
            data[idxPath!.row].type = expenseType
            data[idxPath!.row].desc = expenseDesc
            data[idxPath!.row].date = expenseDate
            data[idxPath!.row].amount = expenseAmount
            add_OR_update = 0
        }
        tableView.reloadData()
    }
}



extension FirstVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _,_,_ in
            guard let self = self else {
                return
            }
            self.deleteItem(indexPath: indexPath)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        let updateAction = UIContextualAction(style: .normal, title: nil) { [weak self] _,_,_ in
            guard let self = self else {
                return
            }
            self.updateItem(indexPath: indexPath)
        }
        updateAction.image = UIImage(systemName: "pencil")
        updateAction.backgroundColor = .systemYellow
        
        let actionConf = UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        
        return actionConf
    }
    
    func deleteItem(indexPath: IndexPath) {
        tableView.beginUpdates()
        
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .middle)
        tableView.reloadData()
        
        tableView.endUpdates()
    }
    
    func updateItem(indexPath: IndexPath) {
        idxPath = indexPath
        add_OR_update = 1
        performSegue(withIdentifier: Constants.goToNext, sender: self)
    }
    
}



extension FirstVC: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        var differentType: Set<String> = []
//        for info in data {
//            differentType.insert(info.type)
//        }
//        return differentType.count
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tempCell, for: indexPath) as! customTVC
        
        cell.showType.text = data[indexPath.row].type
        
        cell.showDesc.text = data[indexPath.row].desc
        
        cell.showDate.text = data[indexPath.row].date
        
        cell.showAmount.text = data[indexPath.row].amount
        
        cell.self.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeaderNib = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerView) as! headerView
        
        customHeaderNib.showHeaderType.text = "Total expenses"
        
        var totalAmount = 0

        for info in data {
            totalAmount += Int(info.amount) ?? 0
        }
        
        customHeaderNib.showTotalAmount.text = String(totalAmount)
        
        return customHeaderNib
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
}

