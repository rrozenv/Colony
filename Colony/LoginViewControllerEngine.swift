
import Foundation
import PromiseKit
import RealmSwift
import FBSDKLoginKit

protocol LoginBusinessLogic {
    func createUser(request: Login.Request)
    func loginUser(request: Login.Request)
    func createUserWithFacebook()
}

protocol LoginDataStore {
    var user: User? { get }
}

final class LoginEngine: LoginBusinessLogic, LoginDataStore {
    var user: User?
    var presenter: LoginPresentationLogic?
    
    func createUserWithFacebook() {
        RealmLoginManager
            .registerWithFacebook()
            .then { [weak self] (syncUser) -> Void in
                RealmLoginManager.initializeCommonRealm(completion: { (isSuccess) in
                    if isSuccess {
                        self?.getFBUserData()
                    }
                })
            }
            .catch { [weak self] (error) -> Void in
                print(error.localizedDescription)
                let response = Login.Response(user: nil)
                self?.presenter?.presentNewUserMessage(response: response)
        }
    }
    
    func createUser(request: Login.Request) {
        RealmLoginManager
            .register(email: request.email, password: request.password)
            .then { [weak self] (syncUser) -> Void in
                RealmLoginManager.initializeCommonRealm(completion: { (isSuccess) in
                    if isSuccess {
                        let user = User.loadUser(request.name!, request.email)
                        let response = Login.Response(user: user)
                        self?.presenter?.presentNewUserMessage(response: response)
                    } else {
                        let response = Login.Response(user: nil)
                        self?.presenter?.presentNewUserMessage(response: response)
                    }
                })
            }
            .catch { [weak self] (error) -> Void in
                print(error.localizedDescription)
                let response = Login.Response(user: nil)
                self?.presenter?.presentNewUserMessage(response: response)
        }
    }
    
    func loginUser(request: Login.Request) {
        RealmLoginManager
            .login(email: request.email, password: request.password)
            .then { [weak self] (syncUser) -> Void in
                RealmLoginManager.initializeCommonRealm(completion: { (isSuccess) in
                    if isSuccess {
                        let user = User.loadCurrentUser()
                        let response = Login.Response(user: user)
                        self?.presenter?.presentExistingUserMessage(response: response)
                    } else {
                        let response = Login.Response(user: nil)
                        self?.presenter?.presentNewUserMessage(response: response)
                    }
                })
            }
            .catch { [weak self] (error) -> Void in
                print(error.localizedDescription)
                let response = Login.Response(user: nil)
                self?.presenter?.presentExistingUserMessage(response: response)
        }
    }
    
    func getFBUserData() {
        guard FBSDKAccessToken.current() != nil else { return }

        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil) {
                let dict = result as! [String: Any]
                print(dict)
            }
        })
    }
    
}

