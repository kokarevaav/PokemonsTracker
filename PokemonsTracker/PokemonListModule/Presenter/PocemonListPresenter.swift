import Foundation

protocol PokemonListViewProtocol: AnyObject {
    
}

protocol PokemonListPresenterProtocol: AnyObject {
    init(view: PokemonListViewProtocol)
}

class PokemonListPresenter: PokemonListPresenterProtocol {
    let view: PokemonListViewProtocol
    
    required init(view: PokemonListViewProtocol) {
        self.view = view
    }

    
    
}
