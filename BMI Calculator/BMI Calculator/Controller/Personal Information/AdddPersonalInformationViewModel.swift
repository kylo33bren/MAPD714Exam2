//
//  AdddPersonalInformationViewModel.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/15/22.
//  MAPD714 Final Exam
//

import Foundation

protocol AdddPersonalInformationProtocol{
    func failure(_ errorString:String)
    func success(_ successMessage:String)
}


class AdddPersonalInformationViewModel{
    
    var delegete:AdddPersonalInformationProtocol?
    var userModel:UserModel?
    
    func bindViewModel(_ delegete:AdddPersonalInformationProtocol){
        self.delegete = delegete
    }
    
    
    func isInputValid()->Bool{
        var errorString = ""
        
        if userModel?.name == "" {
            errorString = "Name can't be empty"
        }else if userModel?.age  == ""{
            errorString = "Age can't be empty"
        }else if userModel?.weight == 0{
            errorString = "Weight can't be zero"
        } else if userModel?.weight == -1{
            errorString = "Invalid Weight"
        }else if userModel?.height == 0{
            errorString = "Height can't be zero"
        }else if userModel?.height == -1{
            errorString = "Invalid Height"
        }
        if errorString != "" {
            delegete?.failure(errorString)
            return false
        }
        
        return true
    }
    
    func savePersonalInformation(){
        
        // update the BMI value
        let isMetric = userModel?.isMetric ?? false
        let weight = userModel?.weight ?? 0
        let height = userModel?.height ?? 0
        let bmiValue = calculateBMI(weight: weight, height: height, isMetric: isMetric)
        userModel?.bmi = bmiValue
        
        //update user object
        Users.shared.currentUser = userModel
        
        // add data in local DB
        let historyItem = HistoryRealmModel(
            weight: userModel?.weight ?? 0,
            bmi: userModel?.bmi ?? 0,
            date: Date().toString())
        
        let isSaved = realmDB().write(historyItem)
        if isSaved{ self.delegete?.success("Personal details saved") }
        
    }
    
    
    func updatePersonalInformation(){
        
        // update the BMI value
        let isMetric = userModel?.isMetric ?? false
        let weight = userModel?.weight ?? 0
        let height = userModel?.height ?? 0
        let bmiValue = calculateBMI(weight: weight, height: height, isMetric: isMetric)
        userModel?.bmi = bmiValue
        
        
        // create history if the weight is being changed
        if Users.shared.currentUser?.weight ?? 0 != weight{
            
            let historyItem = HistoryRealmModel(
                weight: userModel?.weight ?? 0,
                bmi: userModel?.bmi ?? 0,
                date: Date().toString())
            
             _ = realmDB().write(historyItem)
        }
        
        
        //update user object
        Users.shared.currentUser = userModel
        self.delegete?.success("Personal details updated")
        
    }
    
    
    private func calculateBMI(weight: Double, height: Double, isMetric: Bool) -> Double {
        let bmi:Double
        
        if isMetric{
            bmi = weight / (height * height)
        }else{
            bmi = (weight * 703) / (height * height)
        }
        
        
        // Format the BMI value as a string with two decimal places
        let formattedBMI = String(format: "%.2f", bmi)

        // Convert the formatted string back to a double-precision floating-point number
        let bmiValue = Double(formattedBMI) ?? 0

        return (bmiValue)
    }
    
    
    
    
    
}
