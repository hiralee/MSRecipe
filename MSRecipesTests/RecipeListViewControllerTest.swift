import XCTest
import Contentful
@testable import MSRecipes


class RecipeListViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderInteractor() {
        XCTAssertNotNil(makeSUT().tableView)
    }
    
    func test_viewDidLoad_rendersZeroRecipes() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
    }
    
    // MARK: Helpers
    func makeSUT() -> RecipeListViewController {
        let sut = RecipeListViewController(interactor: RecipeListInteractor(presenter: RecipeListPresenter(), service: ContentfulRecipeService()))
        sut.loadViewIfNeeded()
        return sut
    }
}
