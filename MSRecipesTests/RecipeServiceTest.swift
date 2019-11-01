import Foundation
import XCTest
@testable import MSRecipes

class RecipeServiceTest: XCTestCase {
    func test_noRecipe_fetchImage_returnsNoRecipe() {
        let recipeService = RecipeServiceSpy(recipes: nil, recipeImage: nil, error: Error.connectivity)
        
        recipeService.fetchRecipe { (recipe, error) in
            XCTAssertNil(recipe)
            XCTAssertNotNil(error)
        }
    }
        
    func test_noImage_fetchImage_returnsNoImage() {
        let recipeService = RecipeServiceSpy(recipes: nil, recipeImage: nil, error: Error.connectivity)
        
        recipeService.fetchImage(asset: nil, size: ImageSize(width: 30, height: 30), { (image, error) in
            XCTAssertNil(image)
            XCTAssertNotNil(error)
        })
    }
    
    func test_withImage_fetchImage_returnsImage() {
        let recipeService = RecipeServiceSpy(recipes: nil, recipeImage: RecipeImage(image: UIImage()), error: nil)
        
        recipeService.fetchImage(asset: UIImage(), size: ImageSize(width: 30, height: 30), { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
        })
    }
    
    class RecipeServiceSpy: RecipeService {
        var recipes: [Recipe]?
        var recipeImage: RecipeImage?
        var error: Error?
        
        init(recipes: [Recipe]?, recipeImage: RecipeImage?, error: Error?) {
            self.recipes = recipes
            self.error = error
        }
        
        func fetchRecipe(_ recipeCallback: @escaping ([Recipe]?, Error?) -> ()) {
            if let recipes = recipes {
                recipeCallback(recipes, nil)
            }
            if let error = error {
                recipeCallback(nil, error)
            }
        }
        
        func fetchImage(asset: AnyObject?, size: ImageSize, _ assetCallback: @escaping (RecipeImage?, Error?) -> ()) {
            if let recipeImage = recipeImage {
                assetCallback(recipeImage, nil)
            }
            if let error = error {
                assetCallback(nil, error)
            }
        }
    }
}


