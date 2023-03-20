import UIKit

protocol PokemonListViewProtocol: AnyObject {
    func reloadView()
    func showAlertMessage(title: String, message: String)
}

class PokemonListViewController: UIViewController {

    var presenter: PokemonListPresenterProtocol!
    
    private let tableView = UITableView(frame: .zero, style: .plain)

    private let emptyImage: UIImageView = {
        let image = UIImage(named: "NoInternetImage")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainColor")
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "MainColor")
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(named: "TextColor")
        navigationItem.title = "Pokemons"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.addSubview(emptyImage)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseId)
                
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.fillToSuperView(view: view)
        
        emptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyImage.isHidden = presenter.getPokemonList().count != 0
        return presenter.getPokemonList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseId, for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        cell.setLabelText(num: String(indexPath.row + 1), name: presenter.getPokemonForCell(index: indexPath.row).name)
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonInfoViewController = ModuleBuilder.createPokemonInfoModule(id: indexPath.row + 1)
        navigationController?.pushViewController(pokemonInfoViewController, animated: true)
    }
}

extension PokemonListViewController: PokemonListViewProtocol {
    func showAlertMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
