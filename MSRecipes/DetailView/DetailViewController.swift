import Foundation
import UIKit

class DetailViewController: UIViewController {
    private var recipe: Recipe?
    private var recipeImage: UIImage?
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chefLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private static let chefLabelPrefixString: String = "Created by: "
    private static let tagsLabelPrefixString: String = "Tags: "
    
    convenience init(recipe: Recipe, recipeImage: UIImage) {
        self.init()
        self.recipe = recipe
        self.recipeImage = recipeImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        setupDetailView()
    }
    
    private func setupDetailView() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.recipeImageView.image = strongSelf.recipeImage
            strongSelf.titleLabel.text = strongSelf.recipe?.title
            strongSelf.descriptionLabel.text = strongSelf.recipe?.description
            
            if let chef = strongSelf.recipe?.chef?.name {
                strongSelf.chefLabel.text = DetailViewController.chefLabelPrefixString + chef
            } else {
                strongSelf.chefLabel.isHidden = true
            }
            
            if let tags = strongSelf.recipe?.tags {
                let tagNames: [String] = tags.map({ (tag) -> String in
                    tag.name
                })
                strongSelf.tagsLabel.text = DetailViewController.tagsLabelPrefixString + tagNames.joined(separator: ", ")
            } else {
                strongSelf.tagsLabel.isHidden = true
            }
        }
    }
}
