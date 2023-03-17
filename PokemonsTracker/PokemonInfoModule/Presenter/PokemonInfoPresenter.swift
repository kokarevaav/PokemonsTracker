import Foundation

protocol PokemonInfoPresenterProtocol: AnyObject {
    init(view: PokemonInfoViewProtocol)
}

class PokemonInfoPresenter: PokemonInfoPresenterProtocol {
    let view: PokemonInfoViewProtocol
    var pokemonInfo: PokemonInfo!
    
    required init(view: PokemonInfoViewProtocol) {
        self.view = view
    }
    
    
}
