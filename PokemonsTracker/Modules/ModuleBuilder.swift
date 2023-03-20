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
        if Reachability.isConnectedToNetwork() {
            ApiManager.shared.getPokemonList() { isSuccess in
                DispatchQueue.main.async {
                    if !isSuccess {
                        pokemonListView.showAlertMessage(title: "Something went wrong", message: "Please try again after a while")
                    }
                    pokemonListPresenter.pokemonList = CoreDataManager.shared.fetch(type: PokemonList.self)
                    pokemonListView.reloadView()
                }
            }
        } else {
            DispatchQueue.main.async {
                pokemonListView.showAlertMessage(title: "Please check your Internet Connection", message: "Some pokemons may not appear")
                pokemonListPresenter.pokemonList = CoreDataManager.shared.fetch(type: PokemonList.self)
                pokemonListView.reloadView()
            }
        }
        pokemonListView.presenter = pokemonListPresenter
        return pokemonListView
    }
    
    static func createPokemonInfoModule(id: Int) -> UIViewController {
        let pokemonInfoView = PokemonInfoViewController()
        let pokemonInfoPresenter = PokemonInfoPresenter(view: pokemonInfoView)
        if Reachability.isConnectedToNetwork() {
            ApiManager.shared.getPokemonInfo(pokemonId: id) {
                DispatchQueue.main.async {
                    pokemonInfoPresenter.pokemonInfo = CoreDataManager.shared.fetch(type: PokemonInfo.self).first(where: { $0.id == id})
                    pokemonInfoView.reloadView()
                }
            }
        } else {
            DispatchQueue.main.async {
                pokemonInfoPresenter.pokemonInfo = CoreDataManager.shared.fetch(type: PokemonInfo.self).first(where: { $0.id == id})
                if pokemonInfoPresenter.pokemonInfo != nil {
                    pokemonInfoView.reloadView()
                } else {
                    pokemonInfoView.showAlertMessage(title: "Oops", message: "Check your Internet Connection please")
                    pokemonInfoView.setNoInfoLoadedView()
                }
            }
        }
        pokemonInfoView.presenter = pokemonInfoPresenter
        return pokemonInfoView
    }
}
