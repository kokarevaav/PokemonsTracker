import UIKit

class PokemonListViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: "ViewColor")
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.shared.getPokemonList { pokemons in }
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseId, for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        cell.titleLabel.text = "1"
        return cell
    }
    
    
}

extension PokemonListViewController: UITableViewDelegate {
    
}
