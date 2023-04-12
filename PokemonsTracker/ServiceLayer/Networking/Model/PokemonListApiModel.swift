import Foundation

// MARK: - PokemonList
struct PokemonListApiModel<T: Codable>: Codable {
    let count: Int?
    let results: T?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    
    static let database = CoreDataManager.shared
    func store() {
        guard let pokemonList = Result.database.add(type: PokemonList.self) else { return }
        pokemonList.name = name!
        Result.database.save()
    }
}
