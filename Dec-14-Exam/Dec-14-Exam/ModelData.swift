//
//  ModelData.swift
//  Dec-14-Exam
//
//  Created by Admin on 14/12/22.
//

import Foundation


struct ExpenseList {
    var type: String
    var desc: String
    var date: String
    var amount: String
}

extension ExpenseList{
    static var list: [ExpenseList] = [ExpenseList(type: "Food", desc: "Chicken", date: "12-12-2022", amount: "380"),
                                      ExpenseList(type: "Food", desc: "Chips", date: "14-12-2022", amount: "20"),
                                      ExpenseList(type: "Transport", desc: "Bus", date: "15-12-2022", amount: "40"),
                                      ExpenseList(type: "Extra", desc: "Pizza", date: "14-12-2022", amount: "700")
                                      
    ]
}
