import Foundation
import UIKit

protocol PokemonInfoViewProtocol: AnyObject {
    func reloadView()
}

class PokemonInfoViewController: UIViewController {
    
    var presenter: PokemonInfoPresenterProtocol!
    
    let pokemonImage: UIView = {
        let image = UIView()
        image.backgroundColor = .black
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.textColor = UIColor(named: "TextColor")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainColor")
        setupImage()
    }
    
    private func setupImage() {
        view.addSubview(pokemonImage)
        
        pokemonImage.setPosition(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor,
                                 paddingTop: -40,
                                 paddingLeft: 40,
                                 paddingRight: 40,
                                 height: 280)
    }
    
}

extension PokemonInfoViewController: PokemonInfoViewProtocol {
    func reloadView() {
    }
}
