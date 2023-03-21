import Foundation
import UIKit

protocol PokemonInfoViewProtocol: AnyObject {
    func reloadView()
    func setNoInfoLoadedView()
    func showAlertMessageAndReturn(title: String, message: String)
}

class PokemonInfoViewController: UIViewController {
    
    var presenter: PokemonInfoPresenterProtocol!
    
    private let collectionView = ImagesCollectionView()

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
        setUpCollectionView()
        //setupImage()
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
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.setPosition(top: view.safeAreaLayoutGuide.topAnchor,
                                        left: view.leftAnchor,
                                        bottom: nil,
                                        right: view.rightAnchor,
                                        paddingTop: 10,
                                        paddingLeft: 40,
                                        paddingRight: 40,
                                        height: 280)
    }
    
    private func setupLabels() {
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(heightLabel)
        view.addSubview(weigthLabel)
        
        nameLabel.setPosition(top: collectionView.bottomAnchor,
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
    
    private func setIbOutlets() {
        collectionView.setImages(images: presenter.getImagesData())
        collectionView.reloadData()

        nameLabel.text! += "           \(presenter.getPokemonName())"
        typeLabel.text! += "             \(presenter.getPokemonType())"
        heightLabel.text! += "          \(presenter.getPokemonHeight()) cm"
        weigthLabel.text! += "         \(presenter.getPokemonWeigth()) kg"
    }
    
    private func setNoInfoIbOutlets() {
        collectionView.setNoImageState()
        collectionView.reloadData()
    }
    
}

extension PokemonInfoViewController: PokemonInfoViewProtocol {
    func showAlertMessageAndReturn(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let returnAction = UIAlertAction(title: "Try again", style: .cancel, handler: { [unowned self] saveAction -> Void in
            _ = navigationController?.popToRootViewController(animated: true)
        })
    
        ac.addAction(returnAction)
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func setNoInfoLoadedView() {
        DispatchQueue.main.async {
            self.setNoInfoIbOutlets()
        }
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.setIbOutlets()
        }
    }
}
