
import Foundation

protocol SelectGIFLogic {
    func saveSelectedGIF(_ gif: GIF, completion: () -> Void)
}

protocol SelectGIFDataStore {
    var selectedGIF: GIF? { get set }
}

final class SelectGIFEngine: SelectGIFLogic, SelectGIFDataStore {
    
    //MARK: - Properties
    
    var selectedGIF: GIF?
    
    //MARK: - Logic Methods
    
    func saveSelectedGIF(_ gif: GIF, completion: () -> Void) {
        self.selectedGIF = gif
    }
    
}
