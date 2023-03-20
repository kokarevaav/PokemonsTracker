import Foundation

protocol PokemonInfoPresenterProtocol: AnyObject {
    init(view: PokemonInfoViewProtocol)
    func getImageData() -> Data
    func getPokemonName() -> String
    func getPokemonType() -> String
    func getPokemonHeight() -> String
    func getPokemonWeigth() -> String
    func setPokemonInfo(id: Int)
}

class PokemonInfoPresenter: PokemonInfoPresenterProtocol {
    let view: PokemonInfoViewProtocol
    var pokemonInfo: PokemonInfo!
    
    required init(view: PokemonInfoViewProtocol) {
        self.view = view
    }
    
    func getImageData() -> Data {
        return pokemonInfo.frontDefault as Data
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
    
    func setPokemonInfo(id: Int) {
        if Reachability.isConnectedToNetwork() {
            getPokemonInfoFromApi(id: id)
        } else {
            getPokemonInfoFromCoreData(id: id)
        }
    }
    
    private func getPokemonInfoFromApi(id: Int) {
        ApiManager.shared.getPokemonInfo(pokemonId: id) { isSuccess in
            DispatchQueue.main.async { [self] in
                if !isSuccess {
                    view.showAlertMessage(title: "Something went wrong", message: "Please try again after a while")
                }
                pokemonInfo = CoreDataManager.shared.fetch(type: PokemonInfo.self).first(where: { $0.id == id})
                view.reloadView()
            }
        }
    }
    
    private func getPokemonInfoFromCoreData(id: Int) {
        DispatchQueue.main.async { [self] in
            pokemonInfo = CoreDataManager.shared.fetch(type: PokemonInfo.self).first(where: { $0.id == id})
            if pokemonInfo != nil {
                view.reloadView()
            } else {
                view.showAlertMessage(title: "Oops", message: "Check your Internet Connection please")
                view.setNoInfoLoadedView()
            }
        }
    }
}
