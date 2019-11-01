import Foundation
import UIKit
import Contentful

typealias ImageDownloadHandler = (_ image: UIImage?, _ asset: Asset?, _ error: Error?) -> Void

final class ImageDownloadManager {
    private var completionHandler: ImageDownloadHandler?
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.contentful.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    let imageCache = NSCache<NSString, UIImage>()
    static let shared = ImageDownloadManager()
    private init () {}
    
    func downloadImage(_ asset: Asset?, size: ImageSize, handler: @escaping ImageDownloadHandler) {
        guard let asset = asset else {
            return
        }
        self.completionHandler = handler
        
        if let cachedImage = imageCache.object(forKey: asset.id as NSString) {
            self.completionHandler?(cachedImage, asset, nil)
        } else {
            if let operations = (imageDownloadQueue.operations as? [ContentfulOperation])?.filter({
                $0.asset.id == asset.id
                && $0.isFinished == false
                && $0.isExecuting == true
            }), let operation = operations.first {
                operation.queuePriority = .veryHigh
            } else {
                let operation = ContentfulOperation(asset: asset, size: size)
                operation.downloadHandler = { (image, asset, error) in
                    if let newImage = image, let asset = asset {
                        self.imageCache.setObject(newImage, forKey: asset.id as NSString)
                    }
                    self.completionHandler?(image, asset, error)
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    /* FUNCTION to reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
    func slowDownImageDownloadTaskfor (_ asset: Asset) {
        if let operations = (imageDownloadQueue.operations as? [ContentfulOperation])?.filter({$0.asset.id == asset.id && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
            operation.queuePriority = .low
        }
    }
    
    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
    
}





