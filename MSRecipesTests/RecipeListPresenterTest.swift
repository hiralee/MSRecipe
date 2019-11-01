import XCTest
@testable import MSRecipes

class ResultListPresenterTest: XCTestCase {
    
    func test_presenter_hasView() {
        let view = MockView()
        let presenter = makeSUT(view: view)
        XCTAssertNotNil(presenter.view)
    }
    
    func test_presentErrorCalled_viewCallsShowError() {
        let view = MockView()
        let presenter = makeSUT(view: view)
        presenter.presentErrorLoadingRecipes(error: Error.connectivity)
        
        XCTAssertTrue(view.showErrorLoadingRecipesCalled)
    }
    
    func test_presentRecipes_viewCallsLoadRecipes() {
        let view = MockView()
        let presenter = makeSUT(view: view)
        presenter.presentRecipes([])
        
        XCTAssertTrue(view.loadRecipesCalled)
    }
    
    func test_presentRecipeImages_viewCallsLoadRecipeImage() {
        let view = MockView()
        let presenter = makeSUT(view: view)
        presenter.presentRecipeImages()
        
        XCTAssertTrue(view.loadRecipeImageCalled)
    }
    
    // MARK: Helpers
    
    func makeSUT(view: MockView) -> RecipeListPresenter {
        let presenter = RecipeListPresenter()
        presenter.view = view
        
        return presenter
    }
    
    class MockView: RecipeListViewProtocol {
        var showErrorLoadingRecipesCalled = false
        var loadRecipesCalled = false
        var loadRecipeImageCalled = false
        
        func showErrorLoadingRecipes() {
            showErrorLoadingRecipesCalled = true
        }
        
        func loadRecipes() {
            loadRecipesCalled = true
        }
        
        func loadRecipeImage() {
            loadRecipeImageCalled = true
        }
    }
}

