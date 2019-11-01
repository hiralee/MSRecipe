import XCTest
@testable import MSRecipes

class RecipeListInteractorTest: XCTestCase {
    
    func test_interactor_fetchesRecipes() {
        let presenter = MockPresenter()
        let service = MockService()
        let interactor = makeSUT(presenter: presenter, service: service)
        
        interactor.fetchRecipes(with: ImageSize(width: 30, height: 30))
        
        XCTAssertTrue(service.fetchRecipeCalled)
    }
    
    // MARK: Helpers
    
    func makeSUT(presenter: RecipeListPresentable, service: RecipeService) -> RecipeListInteractor {
        return RecipeListInteractor(presenter: presenter, service: service)
    }
    
    class MockService: RecipeService {
        var fetchRecipeCalled = false
        var fetchImageCalled = false
        
        func fetchRecipe(_ recipeCallback: @escaping ([Recipe]?, Error?) -> ()) {
            fetchRecipeCalled = true
        }
        
        func fetchImage(asset: AnyObject?, size: ImageSize, _ assetCallback: @escaping (RecipeImage?, Error?) -> ()) {
            fetchImageCalled = true
        }
    }
    
    class MockPresenter: RecipeListPresentable {
        var presentErrorLoadingRecipesCalled = false
        var presentRecipesCalled = false
        var presentRecipeImagesCalled = false
        
        init() {
            
        }
        
        func presentErrorLoadingRecipes(error: Error) {
            presentErrorLoadingRecipesCalled = true
        }
        
        func presentRecipes(_ recipes: [Recipe]) {
            presentRecipesCalled = true
        }
        
        func presentRecipeImages() {
            presentRecipeImagesCalled = true
        }
    }
}
