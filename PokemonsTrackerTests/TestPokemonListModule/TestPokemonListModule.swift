import XCTest
@testable import PokemonsTracker

class MockView: PokemonListViewProtocol {
    func reloadView() {
    }
    
    func showAlertMessage(title: String, message: String) {
    }
}

final class TestPokemonListModule: XCTestCase {
    var view: MockView!
    var presenter: PokemonListPresenter!

    override func setUpWithError() throws {
        view = MockView()
        presenter = PokemonListPresenter(view: view)
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
    }

    func testPokemonListModuleExist() {
        XCTAssertNotNil(view, "view is exist")
        XCTAssertNotNil(presenter, "view is exist")
    }

}
