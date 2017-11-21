
import Foundation
import UIKit

protocol CreatePromptFormattingLogic {
    func formatPrompt(response: CreatePrompt.Create.Response)
}

final class CreatePromptFormatter: CreatePromptFormattingLogic {
    
    weak var viewController: PromptsDisplayLogic?
    
    func formatPrompt(response: CreatePrompt.Create.Response) {
        
    }
    
}

