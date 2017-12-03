
import Foundation

protocol CreatePromptReplyLogic {
    var promptTitle: String { get }
    func createPrompt(request: CreatePromptReply.Create.Request, completion: @escaping (Bool) -> Void)
}

protocol CreatePromptReplyDataStore {
    var prompt: Prompt! { get set }
}

final class CreatePromptReplyEngine: CreatePromptReplyLogic, CreatePromptReplyDataStore {
    
    var prompt: Prompt!
    var promptTitle: String {
        return prompt.title
    }
    
    lazy var commonRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.common)
    }()
    
    func createPrompt(request: CreatePromptReply.Create.Request, completion: @escaping (Bool) -> Void) {
        guard let user = User.loadCurrentUser() else { fatalError() }
        let promptReply = PromptReply(user: user, prompt: prompt, body: request.body)
        self.commonRealm
            .update { [weak self] in
                self?.prompt?.replies.append(promptReply)
                user.replies.append(promptReply)
                completion(true)
            }
            .catch { (error) in
                if let realmError = error as? RealmError {
                    print(realmError.description)
                } else {
                    print(error.localizedDescription)
                }
                completion(false)
            }
    }
    
}
