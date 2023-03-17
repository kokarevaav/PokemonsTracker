import Foundation
import UIKit

protocol PokemonInfoViewProtocol: AnyObject {
    func reloadView()
}

class PokemonInfoViewController: UIViewController {
    
    var presenter: PokemonInfoPresenterProtocol!
    
    let imageBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "CellColor")
        return view
    }()
    
    let pokemonImage: UIImageView = {
        let image = UIImageView()
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
    
    let weigthLabel: UILabel = {
        let label = UILabel()
        label.text = "Weigth: "
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
        view.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(pokemonImage)
        
        imageBackgroundView.setPosition(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor,
                                 paddingTop: -40,
                                 paddingLeft: 40,
                                 paddingRight: 40,
                                 height: 280)
        pokemonImage.setPosition(top: imageBackgroundView.topAnchor,
                                 left: imageBackgroundView.leftAnchor,
                                 bottom: imageBackgroundView.bottomAnchor,
                                 right: imageBackgroundView.rightAnchor)
    }
    
    private func setupLabels() {
        view.addSubview(headerLabel)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(heightLabel)
        view.addSubview(weigthLabel)
        
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
        weigthLabel.setPosition(top: heightLabel.bottomAnchor,
                                left: view.leftAnchor,
                                bottom: nil,
                                right: view.rightAnchor,
                                paddingTop: 20,
                                paddingLeft: 12)
    }
    
}

extension PokemonInfoViewController: PokemonInfoViewProtocol {
    func reloadView() {
        DispatchQueue.main.async {
            self.pokemonImage.load(url: self.presenter.getImageURL())
            self.nameLabel.text! += "         \(self.presenter.getPokemonName())"
            self.typeLabel.text! += "         \(self.presenter.getPokemonType())"
            self.heightLabel.text! += "         \(self.presenter.getPokemonHeight()) cm"
            self.weigthLabel.text! += "         \(self.presenter.getPokemonWeigth()) kg"
        }
    }
}
