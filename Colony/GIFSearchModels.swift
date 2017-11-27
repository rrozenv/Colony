
import Foundation

enum GIFSearch {
    
    struct Request {
        let query: String
    }
    
    struct Response {
        var gifs: [GIF]?
    }

    struct ViewModel {
        var displayedGIFS: [GIF]
    }
    
}
