import XCTest
import CoreData
@testable import PokemonsTracker

struct CoreDataTestStack {
        
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "PokemonModel")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
    }
}

final class TestCoreDataManager: XCTestCase {

    var coreDataManager: CoreDataManager!
    var coreDataStack: CoreDataTestStack!
    
    override func setUpWithError() throws {
        coreDataStack = CoreDataTestStack()
        coreDataManager = CoreDataManager(mainContext: coreDataStack.mainContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreatePokemonList() {
        guard let pokemonList = coreDataManager.add(type: PokemonList.self) else { return }
        pokemonList.name = "foo"
        coreDataManager.save()
        let pokemonListFromCoreData = coreDataManager.fetch(type: PokemonList.self)
    
        XCTAssertEqual("foo", pokemonListFromCoreData.first?.name)
    }
    
    func testCreatePokemonInfos() {
        guard let pokemonInfo1 = coreDataManager.add(type: PokemonInfo.self) else { return }
        pokemonInfo1.name = "foo"
        pokemonInfo1.id = 1
        pokemonInfo1.height = 1
        pokemonInfo1.weight = 1
        pokemonInfo1.type = "foo"
        pokemonInfo1.frontDefault = NSData()
        coreDataManager.save()
        guard let pokemonInfo2 = coreDataManager.add(type: PokemonInfo.self) else { return }
        pokemonInfo2.name = "bar"
        pokemonInfo2.id = 2
        pokemonInfo2.height = 2
        pokemonInfo2.weight = 2
        pokemonInfo2.type = "bar"
        pokemonInfo2.frontDefault = NSData()
        coreDataManager.save()
        
        let pokemonInfoList = coreDataManager.fetch(type: PokemonInfo.self)
        
        XCTAssertEqual(pokemonInfoList.count, 2)
        XCTAssertTrue(pokemonInfoList.contains(pokemonInfo1))
        XCTAssertTrue(pokemonInfoList.contains(pokemonInfo2))
    }
    
    func testResetAllRecords() {
        guard let pokemonList = coreDataManager.add(type: PokemonList.self) else { return }
        pokemonList.name = "foo"
        coreDataManager.save()
        guard let pokemonList = coreDataManager.add(type: PokemonList.self) else { return }
        pokemonList.name = "bar"
        coreDataManager.save()
        var pokemonListFromCoreData = coreDataManager.fetch(type: PokemonList.self)
        XCTAssertTrue(!pokemonListFromCoreData.isEmpty)
        
        coreDataManager.resetAllRecords(in: "PokemonList")
        pokemonListFromCoreData = coreDataManager.fetch(type: PokemonList.self)
        XCTAssertTrue(pokemonListFromCoreData.isEmpty)
    }

}
