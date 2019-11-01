import Foundation
import UIKit
import Contentful

class ContentfulOperation: Operation {
    var downloadHandler: ImageDownloadHandler?
    var asset: Asset!
    private var size: ImageSize
    
    override var isAsynchronous: Bool {
        get {
            return  true
        }
    }
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    required init (asset: Asset, size: ImageSize) {
        self.asset = asset
        self.size = size
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        self.executing(true)
        self.downloadImageFromAsset()
    }
    
    func downloadImageFromAsset() {
        let service = ContentfulRecipeService()
        service.fetchImage(asset: asset, size: size) { [weak self] (recipeImage: RecipeImage?, error: Error?) in
            guard let strongSelf = self else { return }
            strongSelf.downloadHandler?(recipeImage?.image, strongSelf.asset, error)
            strongSelf.finish(true)
            strongSelf.executing(false)
        }
    }
}
