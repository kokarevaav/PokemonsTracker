import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
}
