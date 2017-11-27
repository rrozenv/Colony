
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
    var gif: GIF? { get set }
}

final class CreatePromptEngine: CreatePromptLogic, CreatePromptDataStore {
    
    var prompt: Prompt?
    var gif: GIF? //Passed from SelectGIFViewController
    
    lazy var commonRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.common)
    }()
    
    func createPrompt(request: CreatePrompt.Create.Request, completion: @escaping (CreatePromptResult) -> Void) {
        guard let gif = gif else { completion(.missingGIF) ; return }
        print("selected gif url: \(gif.url)")
        let value = Prompt.valueDict(title: request.title, body: request.body)
        self.commonRealm
            .create(Prompt.self, value: value)
            .then { [weak self] (prompt) -> Void in
                self?.prompt = prompt
                completion(.success)
            }
            .catch { (error) in
                completion(CreatePromptResult.error(error))
                if let realmError = error as? RealmError {
                    print(realmError.description)
                } else {
                    print(error.localizedDescription)
                }
        }
    }

}
