import Foundation
import UIKit

protocol PokemonInfoViewProtocol: AnyObject {
    func reloadView()
}

class PokemonInfoViewController: UIViewController {
    
    var presenter: PokemonInfoPresenterProtocol!
    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "CellColor")
        return view
    }()
    
    private let pokemonImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.textColor = UIColor(named: "TextColor")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let weigthLabel: UILabel = {
        let label = UILabel()
        label.text = "Weigth: "
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainColor")
        setUpNavigationItem()
        setupImage()
        setupLabels()
    }
    
    private func setUpNavigationItem() {
        navigationItem.titleView?.setPosition(top: view.topAnchor,
                                              left: view.leftAnchor,
                                              bottom: view.bottomAnchor,
                                              right: view.rightAnchor,
                                              paddingTop: 40)
        navigationItem.title = "Details:"
    }
    
    private func setupImage() {
        view.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(pokemonImage)
        
        imageBackgroundView.setPosition(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor,
                                 paddingTop: 0,
                                 paddingLeft: 40,
                                 paddingRight: 40,
                                 height: 280)
        pokemonImage.setPosition(top: imageBackgroundView.topAnchor,
                                 left: imageBackgroundView.leftAnchor,
                                 bottom: imageBackgroundView.bottomAnchor,
                                 right: imageBackgroundView.rightAnchor)
    }
    
    private func setupLabels() {
        //view.addSubview(headerLabel)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(heightLabel)
        view.addSubview(weigthLabel)
        
        nameLabel.setPosition(top: pokemonImage.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingTop: 20,
                              paddingLeft: 12)
//        nameLabel.setPosition(top: headerLabel.bottomAnchor,
//                              left: view.leftAnchor,
//                              bottom: nil,
//                              right: view.rightAnchor,
//                              paddingTop: 20,
//                              paddingLeft: 12)
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
    
    private func setIbOutlets() {
        pokemonImage.load(url: presenter.getImageURL())
        nameLabel.text! += "           \(presenter.getPokemonName())"
        typeLabel.text! += "             \(presenter.getPokemonType())"
        heightLabel.text! += "          \(presenter.getPokemonHeight()) cm"
        weigthLabel.text! += "         \(presenter.getPokemonWeigth()) kg"
    }
    
}

extension PokemonInfoViewController: PokemonInfoViewProtocol {
    func reloadView() {
        DispatchQueue.main.async {
            self.setIbOutlets()
        }
    }
}
