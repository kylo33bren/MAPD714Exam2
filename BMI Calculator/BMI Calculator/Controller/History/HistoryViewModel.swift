//
//  HistoryViewModel.swift
//  BMI Calculator
//
//  Created by Brendan Rodrigues 301119016 on 12/11/22.
//  MAPD714 Final Exam
//

import Foundation
protocol HistoryProtocol{
    func success()
    func historyEmptySuccess()
    func failure(errorString:String)
}

class HistoryViewModel{
    
    var historyList = [HistoryRealmModel]()
    var delegete:HistoryProtocol?
    
    
    func bindModel(_ delegete:HistoryProtocol){
        self.delegete = delegete
    }
    
    func getHistoryList(){
        historyList = realmDB().fetchData(HistoryRealmModel.self)
        historyList = historyList.reversed()
        delegete?.success()
    }
    
    func deleteItem(_ index:Int){
        // delete item
        let isDeleted = realmDB().delete(historyList[index])
        if isDeleted {
            historyList.remove(at: index)
            delegete?.success()
        }
        
        
        // move the user to details screens if all history deleted
        if historyList.isEmpty{
            delegete?.historyEmptySuccess()
        }
        
        
        
        
        
    }
    
}
