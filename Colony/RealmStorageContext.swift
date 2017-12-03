
import Foundation
import RealmSwift
import PromiseKit

enum RealmError: Error {
    case saveFailed(String)
    case updateFailed(String)
    case createFailed(String?)
    case deleteObjectFailed(String)
    case deleteAllObjectsFailed
    
    var description: String {
        switch self {
        case .saveFailed(let description):
            return "Realm failed to save object: \(description)."
        case .updateFailed(let description):
            return "Realm failed to update object: \(description)"
        case .createFailed(let description):
            return "Realm failed to create object: \(String(describing: description))."
        case .deleteObjectFailed(let description):
            return "Realm failed to delete object: \(description)."
        case .deleteAllObjectsFailed:
            return "Realm failed to delete all objects."
        }
    }
}

final class FetchedResults<T: Persistable> {
    let results: Results<T.ManagedObject>
    
    var count: Int {
        return results.count
    }
    
    init(results: Results<T.ManagedObject>) {
        self.results = results
    }
    
    func value(at index: Int) -> T {
        return T(managedObject: results[index])
    }
    
    func mapResults() -> [T] {
        let mapped = self.results.map { (managedObject) in
            return T(managedObject: managedObject)
        }
        return Array(mapped)
    }
}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}

protocol RealmStorageFunctions {
    func save(object: Object) -> Promise<Void>
    func create<T: Object>(_ model: T.Type, value: [String: Any]?) -> Promise<T>
    func fetch<T: Object>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [T]
    func deleteAll() -> Promise<Void>
    func delete(object: Object) -> Promise<Void>
}

class RealmStorageContext: RealmStorageFunctions {
    
    var realm: Realm
    
    required init(configuration: RealmConfig) {
        self.realm = try! Realm(configuration: configuration.configuration)
    }
    
    func create<T: Object>(_ model: T.Type, value: [String: Any]?) -> Promise<T> {
        return Promise { fullfill, reject in
            do {
                try realm.write {
                    let newObject = realm.create(model as Object.Type, value: value ?? [], update: false) as! T
                    fullfill(newObject)
                }
            } catch {
                reject(RealmError.createFailed(model._realmObjectName() ?? nil))
            }
        }
    }
    
    func createTest<T: Persistable>(_ model: T.Type, value: [String: Any]?) -> Promise<T> {
        return Promise { fullfill, reject in
            do {
                try realm.write {
                    let object = realm.create(T.ManagedObject.self, value: value ?? [], update: false)
                    fullfill(T(managedObject: object))
                }
            } catch {
                reject(RealmError.createFailed("create failed"))
            }
        }
    }
    
    func save(object: Object) -> Promise<Void> {
        return Promise { fullfill, reject in
            do {
                try realm.write {
                    realm.add(object)
                }
                fullfill()
            } catch {
                reject(RealmError.saveFailed(object.description))
            }
        }
    }
    
    func save(objects: [Object]) -> Promise<Void> {
        return Promise { fullfill, reject in
            do {
                try realm.write {
                    realm.add(objects)
                }
                fullfill()
            } catch {
                reject(RealmError.saveFailed("Failed to save sequence."))
            }
        }
    }
    
    func fetch<T: Object>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil) -> [T] {
        
        var objects = self.realm.objects(model as Object.Type)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        return (objects.flatMap { $0 as? T })
        
    }
    
    func fetchTest<T: Persistable>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil) -> [T] {
        
        var objects = self.realm.objects(T.ManagedObject.self)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        return objects.map { T(managedObject: $0) }
        
    }
    
    func update(block: @escaping () -> Void) -> Promise<Void> {
        return Promise { fullfill, reject in
            do {
                try realm.write {
                    block()
                }
                fullfill()
            } catch {
                reject(RealmError.updateFailed("Failed to update."))
            }
        }
    }
    
    func delete(object: Object) -> Promise<Void> {
        return Promise { fullfill, reject in
            do {
                try realm.write {
                    realm.delete(object)
                }
                fullfill()
            } catch {
                reject(RealmError.deleteObjectFailed(object.description))
            }
        }
    }
    
    func deleteAll() -> Promise<Void> {
        return Promise { fullfill, reject in
            do {
                try realm.write {
                    realm.deleteAll()
                }
                fullfill()
            } catch {
                reject(RealmError.deleteAllObjectsFailed)
            }
        }
    }

}


