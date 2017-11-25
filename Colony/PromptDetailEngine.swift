
import Foundation

protocol PromptDetailLogic {
    func fetchPromptReplies(request: PromptDetail.FetchPromptReplies.Request)
    func saveUserCastedScore(request: PromptDetail.SaveUserScoreForReply.Request)
}

protocol PromptDetailDataStore {
    var prompt: Prompt! { get set }
}

final class PromptDetailEngine: PromptDetailLogic, PromptDetailDataStore {
    
    var formatter: PromptDetailFormattingLogic?
    var prompt: Prompt!
    lazy var commonRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.common)
    }()
    
    func fetchPromptReplies(request: PromptDetail.FetchPromptReplies.Request) {
        let replies = Array(prompt.replies)
        let response = PromptDetail.FetchPromptReplies.Response(replies: replies)
        formatter?.formatPromptReplies(response: response)
    }
    
    func saveUserCastedScore(request: PromptDetail.SaveUserScoreForReply.Request) {
        //1. Find reply
        guard let user = User.loadCurrentUser(),
              let reply = prompt.replies.filter(NSPredicate(format: "uniqueID = %@", request.replyId)).first else { return }
        
        //2. Create UserScore
        let userScore = UserScore(value: UserScore.valueDict(user: user, replyId: reply.uniqueID, score: request.score))
        
        //3. Check if user already casted score
        let index = reply.userScores.index { (score) -> Bool in
            score.userId == user.id
        }
        
        //4. Update Realm
        self.commonRealm
            .update {
                if let index = index {
                    reply.userScores.insert(userScore, at: index)
                } else {
                    reply.userScores.append(userScore)
                }
            }
            .catch { (error) in
                print(error.localizedDescription)
            }
    }
    
}
