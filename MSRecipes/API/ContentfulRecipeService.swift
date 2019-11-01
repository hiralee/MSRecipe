import Foundation
import Contentful

final class ContentfulRecipeService: RecipeService {
    var client: Client?
    
    private static let spaceId = "kk2bw5ojx476"
    private static let accessToken = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
    
    func fetchRecipe(_ recipeCallback: @escaping ([Recipe]?, Error?) -> ()) {
        let client = getClient()
        
        let query = Query
            .where(contentTypeId: Recipe.contentTypeId)
            .include(8)
        client.fetchArray(matching: query) { (result) in
            switch result {
            case .success(let arrayResponse):
                let recipes: [Recipe]? = arrayResponse.items as? [Recipe]
                recipeCallback(recipes, nil)
            case .error:
                recipeCallback(nil, Error.connectivity)
            }
        }
    }
    
    func fetchImage(asset: AnyObject?, size: ImageSize, _ assetCallback: @escaping (RecipeImage?, Error?) -> ()) {

        guard let asset = asset as? Asset else {
            assetCallback(nil, Error.invalidData)
            return
        }
        
        let client = getClient()
        client.fetchImage(for: asset as Asset, with: [ImageOption.width(size.width), ImageOption.height(size.height)]) { (result) in
            guard let image = result.value else {
                assetCallback(nil, Error.connectivity)
                return
            }
            assetCallback(RecipeImage(image: image), nil)
        }
    }
    
    private func getClient() -> Client {
        let contentTypeClasses: [EntryDecodable.Type] = [
            Recipe.self,
            Chef.self,
            Tag.self
        ]
        
        return Client(spaceId: ContentfulRecipeService.spaceId,
                      accessToken: ContentfulRecipeService.accessToken,
                      contentTypeClasses: contentTypeClasses)
    }
}
