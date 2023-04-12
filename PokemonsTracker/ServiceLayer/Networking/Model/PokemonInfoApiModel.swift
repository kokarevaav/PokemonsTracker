import Foundation

// MARK: - PokemonInfo
struct PokemonInfoApiModel: Codable {
    let height: Int?
    let id: Int?
    let name: String?
    let sprites: Sprites?
    let types: [TypeElement]?
    let weight: Int?
    
    static let database = CoreDataManager.shared
    func store() {
        guard let pokemonInfo = Result.database.add(type: PokemonInfo.self) else { return }
        pokemonInfo.name = name!
        pokemonInfo.type = (types?.first?.type?.name)!
        pokemonInfo.frontDefault = try! NSData(contentsOf: URL(string: (sprites?.frontDefault)!)!)
        pokemonInfo.backDefault = try! NSData(contentsOf: URL(string: (sprites?.backDefault)!)!)
        pokemonInfo.weight = Int16(weight!)
        pokemonInfo.height = Int16(height!)
        pokemonInfo.id = Int16(id!)
        PokemonInfoApiModel.database.save()
    }
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
    let backDefault: String?
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
    init(backDefault: String?, frontDefault: String?) {
        self.backDefault = backDefault
        self.frontDefault = frontDefault
    }
}
