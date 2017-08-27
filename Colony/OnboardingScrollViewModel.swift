
import Foundation
import UIKit

final class OnboardingScrollViewModel {
    
    init() { }
    
    var pageInfo: [OnboardingPageInfo] {
        let pageOne = OnboardingPageInfo(id: 1, headerString: "Hello", bodyString: "", buttonTitle: "")
        let pageTwo = OnboardingPageInfo(id: 2, headerString: "Bye", bodyString: "", buttonTitle: "")
        return [pageOne, pageTwo]
    }
    
}
