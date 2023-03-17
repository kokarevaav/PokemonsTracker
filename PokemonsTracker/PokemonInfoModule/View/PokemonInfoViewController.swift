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
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.textColor = UIColor(named: "TextColor")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let widthLabel: UILabel = {
        let label = UILabel()
        label.text = "Width: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainColor")
        setupImage()
        setupLabels()
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
    
    private func setupLabels() {
        view.addSubview(headerLabel)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(heightLabel)
        view.addSubview(widthLabel)
        
        headerLabel.setPosition(top: pokemonImage.bottomAnchor,
                                left: view.leftAnchor,
                                bottom: nil,
                                right: view.rightAnchor,
                                paddingTop: 20)
        
        nameLabel.setPosition(top: headerLabel.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingTop: 20,
                              paddingLeft: 12)
        typeLabel.setPosition(top: nameLabel.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingTop: 20,
                              paddingLeft: 12)
        heightLabel.setPosition(top: typeLabel.bottomAnchor,
                                left: view.leftAnchor,
                                bottom: nil,
                                right: view.rightAnchor,
                                paddingTop: 20,
                                paddingLeft: 12)
        widthLabel.setPosition(top: heightLabel.bottomAnchor,
                               left: view.leftAnchor,
                               bottom: nil,
                               right: view.rightAnchor,
                               paddingTop: 20,
                               paddingLeft: 12)
        
    }
    
}

extension PokemonInfoViewController: PokemonInfoViewProtocol {
    func reloadView() {
    }
}
