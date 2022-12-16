//
//  HistoryTableViewCell.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/15/22.
//  MAPD714 Final Exam
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }
    
    func setData(item:HistoryRealmModel){
        weightLabel.text = "\(item.weight)"
        bmiLabel.text = "\(item.bmi)"
        dateLabel.text = item.date
    }
    
    
    
}
