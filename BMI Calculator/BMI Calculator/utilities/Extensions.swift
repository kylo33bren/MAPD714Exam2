//
//  Extensions.swift
//  ToDo
//
//  Created by Brendan Rodrigues 301119016 on 12/11/22.
//  MAPD714 Final Exam
//

import Foundation
import UIKit

extension Date{
    func toString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: self)
    }

}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}


extension String {
    func toDate() -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: self)!
    }
}
