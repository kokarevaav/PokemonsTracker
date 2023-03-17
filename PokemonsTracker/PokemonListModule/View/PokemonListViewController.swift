import UIKit

protocol PokemonListViewProtocol: AnyObject {
    func reloadView()
}

class PokemonListViewController: UIViewController {

    var presenter: PokemonListPresenterProtocol!
    var pokemonList: [Result] = []
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: "MainColor")
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ApiManager.shared.getPokemonList { pokemons in }
        ApiManager.shared.getPokemonInfo(pokemonId: 20) { pokemonInfo in }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseId)
                
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.fillToSuperView(view: view)
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseId, for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        cell.titleLabel.text = self.pokemonList[indexPath.row].name
        return cell
    }
    
    
}

extension PokemonListViewController: UITableViewDelegate {
    
}

extension PokemonListViewController: PokemonListViewProtocol {
    func reloadView() {
        DispatchQueue.main.async {
            self.pokemonList = self.presenter.getPokemonList()
            self.tableView.reloadData()
        }
    }
}
