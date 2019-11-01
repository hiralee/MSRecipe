import Foundation
import UIKit

struct ImageSize {
    let width: UInt
    let height: UInt
}

protocol RecipeListViewProtocol: class {
    func showErrorLoadingRecipes()
    func loadRecipes()
    func loadRecipeImage()
}

class RecipeListViewController: UIViewController, RecipeListViewProtocol, UITableViewDelegate, UITableViewDataSource {
    private var interactor: RecipeListInteractable?
    
    private let reuseIdentifier = "RecipeCell"
    private let recipeImageWidth: UInt = UInt(UIScreen.main.bounds.size.width)
    private let recipeImageHeight: UInt = 260
    
    @IBOutlet weak var tableView: UITableView!
    
    convenience init(interactor: RecipeListInteractable) {
        self.init()
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Recipes"
        setupTableView()
        fetchRecipes()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(RecipeCell.self)
    }
    
    private func fetchRecipes() {
        showSpinner(onView: view)
        interactor?.fetchRecipes(with: ImageSize(width: recipeImageWidth, height: recipeImageHeight))
    }
    
    func showErrorLoadingRecipes() {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            let alert = UIAlertController(title: "Error fetching Recipes", message: "Please try in sometime.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func loadRecipes() {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            self?.tableView.reloadData()
        }
    }
    
    func loadRecipeImage() {
        DispatchQueue.main.async { [weak self] in
            UIView.performWithoutAnimation {
                self?.tableView.reloadData()
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.recipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? RecipeCell
        
        guard let recipe = interactor?.recipes[indexPath.row] else { return cell! }
        cell?.title.text = recipe.title

        guard let photo = recipe.photo, let image = interactor?.recipeAssests[photo.id] else { return cell! }
        cell?.recipeImage.image = image

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = interactor?.recipes[indexPath.row] else { return }
        guard let recipeImage = recipe.photo, let image = interactor?.recipeAssests[recipeImage.id] else { return }
        
        let detailsView = DetailViewController(recipe: recipe, recipeImage: image)
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
}
