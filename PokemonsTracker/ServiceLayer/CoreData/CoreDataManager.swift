import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private var viewContext: NSManagedObjectContext!
    
    private init() {
        self.viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func add<T: NSManagedObject>(type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }

    func fetch<T: NSManagedObject>(type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func resetAllRecords(in entityName : String) {
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch {
            print ("There was an error")
        }
    }
}
