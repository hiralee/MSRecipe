import Foundation

public enum Error: Swift.Error {
    case connectivity
    case invalidData
}

protocol RecipeService {
    func fetchRecipe(_ recipeCallback: @escaping ([Recipe]?, Error?) -> ())
    func fetchImage(asset: AnyObject?, size: ImageSize, _ assetCallback: @escaping (RecipeImage?, Error?) -> ())
}
