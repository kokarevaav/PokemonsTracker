//import UIKit
//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//
//    private init() { }
//
//    private func getContext() -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
//
//    func loadPokemonList() -> [Pokemon]? {
//        let context = getContext()
//        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
//        do {
//            let pokemonList = try context.fetch(fetchRequest)
//            return pokemonList
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return nil
//        }
//    }
//
////    func deletePokemonList() {
////        let context = getContext()
////        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
////
////        if let objects = try? context.fetch(fetchRequest) {
////            for object in objects {
////                context.delete(object)
////            }
////        }
////        saveContext(context: context)
////    }
////
////    func addPokemon(pokemonName: String, pokemonType: String, pokemonHeight: String, pokemonWeight: String, pokemonImageURL: String) -> Pokemon? {
////        let context = getContext()
////
////        guard let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context) else { return nil }
////
////        let pokemonObject = Pokemon(entity: entity, insertInto: context)
////        pokemonObject.name = pokemonName
////        pokemonObject.type = pokemonType
////        pokemonObject.height = pokemonHeight
////        pokemonObject.weight = pokemonWeight
////        pokemonObject.frontImageURL = pokemonImageURL
////
////        do {
////            try context.save()
////            return pokemonObject
////
////        } catch let error as NSError {
////            print(error.localizedDescription)
////            return nil
////        }
////    }
//
//    func savePokemons(pokemons: [Pokemon]) {
//
//        for i in 0..<pokemons.count {
//            let context = getContext()
//
//            guard let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context) else { return }
//
//            let pokemonObject = Pokemon(entity: entity, insertInto: context)
//            pokemonObject.name = pokemons[i].name
//            pokemonObject.type = pokemons[i].type
//            pokemonObject.height = pokemons[i].height
//            pokemonObject.weight = pokemons[i].weight
//            pokemonObject.frontImageURL = pokemons[i].frontImageURL
//            pokemonObject.isRead = pokemons[i].isRead
//
//            saveContext(context: context)
//        }
//    }
//
//    private func saveContext(context: NSManagedObjectContext) {
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//}
//
