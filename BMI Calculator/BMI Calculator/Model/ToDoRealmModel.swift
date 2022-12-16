
import Foundation
import RealmSwift

class HistoryRealmModel:Object{
    @Persisted(primaryKey: true) var id:Int
    @Persisted var weight:Double
    @Persisted var bmi:Double
    @Persisted var date:String
    
    convenience init(weight:Double,bmi:Double,date:String){
        self.init()

        self.id = Int(Date().currentTimeMillis())
        self.weight = weight
        self.bmi = bmi
        self.date = date
    }

    
    
}


