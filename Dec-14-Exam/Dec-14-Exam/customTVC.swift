//
//  customTVC.swift
//  Dec-14-Exam
//
//  Created by Admin on 14/12/22.
//

import UIKit

class customTVC: UITableViewCell {


    @IBOutlet weak var showType: UILabel!
    
    @IBOutlet weak var showDesc: UILabel!
    
    @IBOutlet weak var showDate: UILabel!
    
    @IBOutlet weak var showAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
