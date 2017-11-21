
import Foundation

protocol CreatePromptLogic {
    func createPrompt(request: CreatePrompt.Create.Request, completion: @escaping (Bool) -> Void)
}

protocol CreatePromptDataStore {
    var prompt: Prompt? { get set }
}

final class CreatePromptEngine: CreatePromptLogic, CreatePromptDataStore {
    
    var prompt: Prompt?
    
    lazy var commonRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.common)
    }()
    
    func createPrompt(request: CreatePrompt.Create.Request, completion: @escaping (Bool) -> Void) {
        let value = Prompt.valueDict(title: request.title, body: request.body)
        self.commonRealm
            .create(Prompt.self, value: value)
            .then { (_) in
                completion(true)
            }
            .catch { (error) in
                completion(false)
                if let realmError = error as? RealmError {
                    print(realmError.description)
                } else {
                    print(error.localizedDescription)
                }
        }
    }
    
}
