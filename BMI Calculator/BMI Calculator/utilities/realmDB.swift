//
//  ViewController.swift
//  ToDo
//
//  Created by Brendan Rodrigues 301119016 on 12/11/22.
//  MAPD714 Final Exam
//

import Foundation
import UIKit
import RealmSwift

class realmDB {
    fileprivate var realm: Realm? {
        do {
            return try Realm()
        } catch let error {
            let nsError: NSError = error as NSError
            if nsError.code == 10 {
                guard let defaultPath: URL = Realm.Configuration.defaultConfiguration.fileURL else { return nil }
                try? FileManager.default.removeItem(at: defaultPath)
                return self.realm
            }
            print("Default realm init failed: ", error)
        }
        return nil
    }
    
    func object<T: Object>() -> T? {
        let key: AnyObject = 0 as AnyObject
        return self.object(key)
    }
    
    func object<T: Object>(_ key: Any?) -> T? {
        guard let key: Any = key else { return nil }
        guard let realm: Realm = self.realm else { return nil }
        guard let object: T = realm.object(ofType: T.self, forPrimaryKey: key) else { return nil }
        return !object.isInvalidated ? object : nil
    }
    
    func object<T: Object>(_ predicate: (T) -> Bool) -> T? {
        guard let realm: Realm = self.realm else { return nil }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated }).first
    }
    
    func objects<T: Object>() -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter({ !$0.isInvalidated })
    }
    
    func objects<T: Object>(_ predicate: (T) -> Bool) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated })
    }
    
    func write<T: Object>(_ object: T?) -> Bool {
        guard let object: T = object else { return false }
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return false }
        
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
            return true
        } catch let error {
            print("Writing failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    
    
    func write<T: Object>(_ objects: [T]?) -> Bool {
        guard let objects: [T] = objects else { return false }
        guard let realm: Realm = self.realm else { return false }
        let validated: [T] = objects.filter({ !$0.isInvalidated })
        do {
            try realm.write {
                realm.add(validated, update: .all)
            }
            return true
        } catch let error {
            print("Writing of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    func update(_ block: () -> ()) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        do {
            try realm.write(block)
            return true
        } catch let error {
            print("Updating failed with error ", error)
        }
        return false
    }
    
    func delete<T: Object>(_ object: T) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return true }
        do {
            try realm.write {
                realm.delete(object)
            }
            return true
        } catch let error {
            print("Writing of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }

    func fetchData<T: Object>(_ objectType: T.Type, _ predicate: NSPredicate ) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        let data = Array(realm.objects(T.self).filter(predicate))
        return data
    }
    
    func fetchData<T: Object>(_ objectType: T.Type) -> [T] {
        guard let realm: Realm = self.realm else { return [] }
        let data = Array(realm.objects(T.self))
        return data
    }
    
    
}

