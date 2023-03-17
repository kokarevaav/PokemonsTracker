import Foundation

protocol PokemonListPresenterProtocol: AnyObject {
    init(view: PokemonListViewProtocol)
    func getPokemonList() -> [Result]
}

class PokemonListPresenter: PokemonListPresenterProtocol {
    let view: PokemonListViewProtocol
    var pokemonList: [Result]
    
    required init(view: PokemonListViewProtocol) {
        self.view = view
        self.pokemonList = []
    }
    
    func getPokemonList() -> [Result] {
        return self.pokemonList
    }
}
