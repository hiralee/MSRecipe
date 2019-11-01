import Foundation
import UIKit

protocol RecipeListPresentable {
    func presentErrorLoadingRecipes(error: Error)
    func presentRecipes(_ recipes: [Recipe])
    func presentRecipeImages()
}

class RecipeListPresenter: RecipeListPresentable {
    weak var view: RecipeListViewProtocol?
    
    func presentErrorLoadingRecipes(error: Error) {
        view?.showErrorLoadingRecipes()
    }
    
    func presentRecipes(_ recipes: [Recipe]) {
        view?.loadRecipes()
    }
    
    func presentRecipeImages() {
        view?.loadRecipeImage()
    }
}
