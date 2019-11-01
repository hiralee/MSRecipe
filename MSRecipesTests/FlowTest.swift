import Foundation
import XCTest
@testable import MSRecipes

class FlowTest: XCTestCase {
    
    func test_initFlow_returnsViewController() {
        let viewController = Flow().initiateFlow()
        
        XCTAssertTrue(viewController.isKind(of: UIViewController.self))
    }
    
    func test_initFlow_returnsViewController_ofTypeRecipeListViewController() {
        let viewController = Flow().initiateFlow()
        let recipeListViewController = viewController as? RecipeListViewController
        
        XCTAssertTrue(recipeListViewController!.isKind(of: RecipeListViewController.self))
    }
}
