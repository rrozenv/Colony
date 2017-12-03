
import Foundation

enum CreatePromptResult {
    case success
    case missingTitle
    case missingBody
    case missingGIF
    case error(Error)
}

protocol CreatePromptLogic {
    func createPrompt(request: CreatePrompt.Create.Request, completion: @escaping (CreatePromptResult) -> Void)
}

protocol CreatePromptDataStore {
    var prompt: Prompt? { get set }
    var image: Imageable? { get set }
}

final class CreatePromptEngine: CreatePromptLogic, CreatePromptDataStore {
    
    var prompt: Prompt?
    var image: Imageable? //Passed from SelectGIFViewController
    
    lazy var commonRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.common)
    }()
    
    func createPrompt(request: CreatePrompt.Create.Request, completion: @escaping (CreatePromptResult) -> Void) {
        guard let image = image else { completion(.missingGIF) ; return }
        let value = Prompt_R.valueDict(title: request.title, body: request.body, imageURL: image.urlString)
//        let prompt = PromptT(id: UUID().uuidString, title: request.title, body: request.body, imageUrl: image.urlString, createdAt: Date())
        self.commonRealm.createTest(PromptT.self, value: value)
            .then { (prompt) -> Void in
                //self?.prompt = prompt
                let promptT = PromptT(managedObject: prompt)
                completion(.success)
            }
            .catch { (error) in
                completion(.error(error))
                if let realmError = error as? RealmError {
                    print(realmError.description)
                } else {
                    print(error.localizedDescription)
                }
            }
        
//        self.commonRealm
//            .create(Prompt.self, value: value)
//            .then { [weak self] (prompt) -> Void in
//                self?.prompt = prompt
//                completion(.success)
//            }
//            .catch { (error) in
//                completion(.error(error))
//                if let realmError = error as? RealmError {
//                    print(realmError.description)
//                } else {
//                    print(error.localizedDescription)
//                }
//            }
    }

}
