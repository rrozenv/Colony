
import Foundation
import CoreLocation

protocol HomeBusinessLogic {
    func fetchCurrentLocation()
}

final class HomeEngine: HomeBusinessLogic {
    
    lazy var privateRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.secret)
    }()
    
    func fetchCurrentLocation() {
       
    }
    
}

