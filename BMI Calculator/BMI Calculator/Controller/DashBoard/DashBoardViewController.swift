//
//  DashBoardViewController.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/13/22.
//  MAPD714 Final Exam
//

import UIKit

class DashBoardViewController: UIViewController {

    @IBOutlet weak var BMILabel:UILabel!
    @IBOutlet weak var categoryLabel:UILabel!
    
    
    private let viewModel = DashBoardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bindViewModel(self)
        viewModel.getBMIValues()
    }
    
    @IBAction func historyTapped(_ sender:UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func editProfile(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPersonalInformationViewController") as! AddPersonalInformationViewController
        vc.InfoScreenType = .edit
        vc.profileUpdated = { self.viewModel.getBMIValues() }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension DashBoardViewController:DashBoardProtocol{
    func success() {
        
    }
    
    func failure(_ errorString: String) {
        Utility.showLoaf(message: errorString, state: .error)
    }
    
    func BMISuccess(_ value: Double, _ category: String) {
        self.BMILabel.text = "\(value)"
        self.categoryLabel.text = category
        
    }
    
    
}
