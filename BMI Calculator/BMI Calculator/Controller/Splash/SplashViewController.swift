//
//  SplashViewController.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/15/22.
//  MAPD714 Final Exam
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            
            
            let historyCount = self.getHistoryCount()
            
            let personalInfoVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPersonalInformationViewController")
            
            let dashboardVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController")
            
            
            super.setRootViewController(historyCount == 0 ? personalInfoVc : dashboardVc)
        }
        
    }
    
    
    func getHistoryCount()->Int{
        let allObjects = realmDB().fetchData(HistoryRealmModel.self)
        return allObjects.count
    }
}
