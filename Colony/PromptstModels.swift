
import Foundation

enum Prompts {
 
    enum FetchPrompts {
        struct Request { }
        
        struct Response {
            var prompts: [Prompt]
        }
        
        //Presenter Output -> View Controller Input
        struct ViewModel {
            struct DisplayedPrompt {
                let title: String
                let body: String
                let imageURL: URL?
                let replyCount: String
            }
            var prompts: [DisplayedPrompt]
        }
    }
    
//    struct Alert {
//        static func failedFetchingMovies() -> CustomAlertViewController.AlertInfo {
//            return CustomAlertViewController.AlertInfo(header: "Failed Fetching Movies", message: "Oops!", okButtonTitle: "OK", cancelButtonTitle: nil)
//        }
//    }
//
//    struct Seeds {
//        static func genearteTestMovies() -> [Movie_R] {
//            let movieOne = Movie_R()
//            movieOne.movieID = "1"
//            movieOne.year = "1999"
//            let movieTwo = Movie_R()
//            movieTwo.movieID = "2"
//            movieTwo.year = "2000"
//            return [movieOne, movieTwo]
//        }
//    }
    
}
