//
//  DashBoardViewModel.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/13/22.
//  MAPD714 Final Exam
//

import Foundation

protocol DashBoardProtocol{
    func success()
    func failure(_ errorString:String)
    func BMISuccess(_ value: Double,_ category: String)
}



class DashBoardViewModel{

    
    var delegete:DashBoardProtocol?
    
    
    func bindViewModel(_ delegete:DashBoardProtocol){
        self.delegete = delegete
    }
    
    
    func getBMIValues(){
        let bmi = Users.shared.currentUser?.bmi ?? 0
        let category = getCat(bmiValue: bmi)
        delegete?.BMISuccess(bmi, category)
    }
    
   

    func getCat(bmiValue:Double)->String{
        var category: String
        if bmiValue < 16 {
            category = "Severe Thinness"
        } else if bmiValue >= 16 && bmiValue < 17 {
            category = "Moderate Thinness"
        } else if bmiValue >= 17 && bmiValue < 18.5 {
            category = "Mid Thinness"
        } else if bmiValue >= 18.5 && bmiValue < 25 {
            category = "Normal"
        } else if bmiValue >= 25 && bmiValue < 30 {
            category = "Overweight"
        } else if bmiValue >= 30 && bmiValue < 35 {
            category = "Obese Class |"
        } else if bmiValue >= 34 && bmiValue < 40 {
            category = "Obese Class ||"
        } else {
            category = "Obese Class |||"
        }
        
        return category
    }



}
