
import Foundation

import Foundation
struct Keys {
    static let currentUser = "currentUser"
}


class Users{
    static let shared = Users()
    
    var currentUser:UserModel?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: Keys.currentUser)
                return
            }
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:Keys.currentUser)
            UserDefaults.standard.synchronize()
        }
        
        get{
            var session : UserModel? = nil
            if let data = UserDefaults.standard.value(forKey: Keys.currentUser) as? Data {
                session = try? PropertyListDecoder().decode(UserModel.self, from: data)
            }
            return session
            
        }
    }
    
}
