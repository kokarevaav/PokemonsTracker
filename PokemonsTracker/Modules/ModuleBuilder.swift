import Foundation
import UIKit

protocol Buider {
    static func createPokemonListModule() -> UIViewController
    static func createPokemonInfoModule(id: Int) -> UIViewController
}

class ModuleBuilder: Buider {
    static func createPokemonListModule() -> UIViewController {
        let pokemonListView = PokemonListViewController()
        let pokemonListPresenter = PokemonListPresenter(view: pokemonListView)
        pokemonListPresenter.setPokemonList()
        pokemonListView.presenter = pokemonListPresenter
        return pokemonListView
    }
    
    static func createPokemonInfoModule(id: Int) -> UIViewController {
        let pokemonInfoView = PokemonInfoViewController()
        let pokemonInfoPresenter = PokemonInfoPresenter(view: pokemonInfoView)
        pokemonInfoPresenter.setPokemonInfo(id: id)
        pokemonInfoView.presenter = pokemonInfoPresenter
        return pokemonInfoView
    }
}
