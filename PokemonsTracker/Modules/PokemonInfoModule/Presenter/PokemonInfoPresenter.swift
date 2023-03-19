import Foundation

protocol PokemonInfoPresenterProtocol: AnyObject {
    init(view: PokemonInfoViewProtocol)
    func getImageURL() -> URL
    func getPokemonName() -> String
    func getPokemonType() -> String
    func getPokemonHeight() -> String
    func getPokemonWeigth() -> String
}

class PokemonInfoPresenter: PokemonInfoPresenterProtocol {
    let view: PokemonInfoViewProtocol
    var pokemonInfo: PokemonInfo!
    
    required init(view: PokemonInfoViewProtocol) {
        self.view = view
    }
    
    func getImageURL() -> URL {
        return URL(string: pokemonInfo.frontDefault)!
    }
    
    func getPokemonName() -> String {
        return pokemonInfo.name
    }
    
    func getPokemonType() -> String {
        return pokemonInfo.type
    }
    
    func getPokemonHeight() -> String {
        return String(pokemonInfo.height)
    }
    
    func getPokemonWeigth() -> String {
        return String(pokemonInfo.weight)
    }
}
