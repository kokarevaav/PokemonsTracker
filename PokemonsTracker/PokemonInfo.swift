import Foundation

// MARK: - PokemonList
struct PokemonInfo: Codable {
    let height: Int?
    let id: Int?
    let name: String?
    let types: [TypeElement]?
    let weight: Int?
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let type: Species?
}

// MARK: - Species
struct Species: Codable {
    let name: String?
}

// MARK: - Sprites
class Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    init(frontDefault: String?) {
        self.frontDefault = frontDefault
    }
}

