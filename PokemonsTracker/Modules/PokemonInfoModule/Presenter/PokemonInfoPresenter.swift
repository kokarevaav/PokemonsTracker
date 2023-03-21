import Foundation

protocol PokemonInfoPresenterProtocol: AnyObject {
    init(view: PokemonInfoViewProtocol)
    func getImagesData() -> [Data]
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
    
    func getImagesData() -> [Data] {
        let imagesData: [Data] = [pokemonInfo.frontDefault as Data, pokemonInfo.backDefault as Data]
        return imagesData
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
        ApiManager.shared.getPokemonInfo(pokemonId: id) { [self] isSuccess in
            if !isSuccess {
                view.showAlertMessageAndReturn(title: "Something went wrong", message: "Please try again after a while")
            }
            pokemonInfo = CoreDataManager.shared.fetch(type: PokemonInfo.self).first(where: { $0.id == id})
            view.reloadView()
        }
    }
    
    private func getPokemonInfoFromCoreData(id: Int) {
        pokemonInfo = CoreDataManager.shared.fetch(type: PokemonInfo.self).first(where: { $0.id == id})
        if pokemonInfo != nil {
            view.reloadView()
        } else {
            view.showAlertMessageAndReturn(title: "Oops", message: "Check your Internet Connection please and try again")
            view.setNoInfoLoadedView()
        }
    }
}
