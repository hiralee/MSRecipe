import UIKit
import Contentful

class RecipeListInteractor {
    var recipes: [Recipe] = []
    var recipeAssests: [String: UIImage] = [:]
    
    private let dispatchGroup = DispatchGroup()
    private let queue = DispatchQueue(label: "AssetQueue", attributes: .concurrent)
    private var presenter: RecipeListPresentable?
    private let service: RecipeService

    init(presenter: RecipeListPresentable, service: RecipeService) {
        self.presenter = presenter
        self.service = service
    }
    
    func fetchRecipes(with imageSize: ImageSize) {
        service.fetchRecipe { [weak self] (recipes: [Recipe]?, error: Error?) in
            guard let recipes = recipes else {
                if let error = error {
                    self?.presenter?.presentErrorLoadingRecipes(error: error)
                }
                return
            }
            self?.recipes = recipes
            self?.fetchImages(with: imageSize)
            self?.presenter?.presentRecipes(recipes)
        }
    }
    
    func fetchAsset(asset: Asset?, size: ImageSize, index: Int) {
        ImageDownloadManager.shared.downloadImage(asset, size: size) { [weak self] (image, asset, error) in
            if let image = image, let asset = asset {
                // use shared exclusion lock on asset dictionary to allow only one thread to write
                self?.queue.async(flags: .barrier) {
                    self?.recipeAssests[asset.id] = image
                }
                self?.dispatchGroup.leave()
            }
        }
    }
    
    private func fetchImages(with imageSize: ImageSize) {
        var index = 0
        
        for recipe in recipes {
            dispatchGroup.enter()
            fetchAsset(asset: recipe.photo, size: imageSize, index: index)
            index += 1
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.presenter?.presentRecipeImages()
        }
    }
}
