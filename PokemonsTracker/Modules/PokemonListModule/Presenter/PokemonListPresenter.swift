import Foundation

protocol PokemonListPresenterProtocol: AnyObject {
    init(view: PokemonListViewProtocol)
    func getPokemonList() -> [PokemonList]
    func getPokemonForCell(index: Int) -> PokemonList
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
}
