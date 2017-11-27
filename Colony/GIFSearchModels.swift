
import Foundation
import UIKit

enum GIFSearch {
    
    struct Request {
        let query: String
    }
    
    struct Response {
        var images: [Imageable]?
    }

    struct ViewModel {
        var displayedImages: [Imageable]
    }
    
}
