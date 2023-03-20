import CoreData

public class PokemonInfo: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var frontDefault: NSData
    @NSManaged var weight: Int16
    @NSManaged var height: Int16
    @NSManaged var id: Int16
}
