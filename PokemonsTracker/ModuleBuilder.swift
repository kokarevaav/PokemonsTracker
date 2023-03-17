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
        ApiManager.shared.getPokemonList() { data in
            guard !data.isEmpty else {
//                DispatchQueue.main.async {
//                    quizView.showAlert(title: "Oops! Something went wrong..", message: "Please check your internet connection and try again!")
                //}
                return
            }
            pokemonListPresenter.pokemonList = data
            pokemonListView.reloadView()
        }
        pokemonListView.presenter = pokemonListPresenter
        return pokemonListView
    }
    
    static func createPokemonInfoModule(id: Int) -> UIViewController {
        let pokemonInfoView = PokemonInfoViewController()
        let pokemonInfoPresenter = PokemonInfoPresenter(view: pokemonInfoView)
        ApiManager.shared.getPokemonInfo(pokemonId: id) { data in
            guard let data = data else {
                // MARK: - add
                return
            }
            pokemonInfoPresenter.pokemonInfo = data
            pokemonInfoView.reloadView()
        }
        pokemonInfoView.presenter = pokemonInfoPresenter
        return pokemonInfoView
    }
}
