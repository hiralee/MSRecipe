import Foundation
import UIKit

class Flow {    
    func initiateFlow() -> UIViewController {
        let presenter = RecipeListPresenter()
        let interactor = RecipeListInteractor(presenter: presenter, service: ContentfulRecipeService())
        let viewController = RecipeListViewController(interactor: interactor)
        presenter.view = viewController
        
        return viewController
    }
}
