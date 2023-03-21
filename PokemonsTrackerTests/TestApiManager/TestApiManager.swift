import XCTest
@testable import PokemonsTracker

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    private (set) var lastURL: URL?
    var data: Data?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        let data = self.data
        let error = self.error
        completionHandler(data, nil, error)
        return nextDataTask
    }
}

final class TestApiManager: XCTestCase {
    var apiManager: ApiManager!
    let session = MockURLSession()
    
    override func setUpWithError() throws {
        apiManager = ApiManager(session: session)
    }

    override func tearDownWithError() throws {
    }

    func testResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
      
        apiManager.getPokemonList(completion: ) { success in
            // Return data
        }
        XCTAssert(dataTask.resumeWasCalled)
    }
}
