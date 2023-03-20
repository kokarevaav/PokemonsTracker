import Foundation

protocol PokemonListPresenterProtocol: AnyObject {
    init(view: PokemonListViewProtocol)
    func getPokemonList() -> [PokemonList]
    func getPokemonForCell(index: Int) -> PokemonList
    func setPokemonList()
}

class PokemonListPresenter: PokemonListPresenterProtocol {
    let view: PokemonListViewProtocol
    var pokemonList: [PokemonList]
    
    required init(view: PokemonListViewProtocol) {
        self.view = view
        self.pokemonList = []
    }
    
    func getPokemonList() -> [PokemonList] {
        return self.pokemonList
    }
    
    func getPokemonForCell(index: Int) -> PokemonList {
        return pokemonList[index]
    }
    
    func setPokemonList() {
        if Reachability.isConnectedToNetwork() {
            getPokemonListFromApi()
        } else {
            getPokemonListFromCoreData()
        }
    }
    
    private func getPokemonListFromApi() {
        ApiManager.shared.getPokemonList() { isSuccess in
            DispatchQueue.main.async { [self] in
                if !isSuccess {
                    view.showAlertMessage(title: "Something went wrong", message: "Please try again after a while")
                }
                pokemonList = CoreDataManager.shared.fetch(type: PokemonList.self)
                view.reloadView()
            }
        }
    }
    
    private func getPokemonListFromCoreData() {
        DispatchQueue.main.async { [self] in
            view.showAlertMessage(title: "Please check your Internet Connection", message: "Some pokemons may not appear")
            pokemonList = CoreDataManager.shared.fetch(type: PokemonList.self)
            view.reloadView()
        }
    }
}
