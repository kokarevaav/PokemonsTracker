import Foundation
import CoreData

enum ApiType {
    case getPokemonList
    case getPokemonInfo(id: String)
    
    var baseURL: String {
        return "https://pokeapi.co/api/v2/pokemon/"
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var path: String {
        switch self {
        case .getPokemonList: return self.baseURL
        case .getPokemonInfo(let id): return "\(id)/"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        return request
    }
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol { func resume() }

class ApiManager {
    static let shared = ApiManager(session: URLSession.shared)
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getPokemonList(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let request = ApiType.getPokemonList.request
        let task = session.dataTask(with: request) { data, response, error -> Void in
            if error != nil {
                completion(false)
                return
            }
            if let data = data, let pokemonList = try? JSONDecoder().decode(PokemonListApiModel<[Result]>.self, from: data) {
                CoreDataManager.shared.resetAllRecords(in: "PokemonList")
                pokemonList.results!.forEach { $0.store() }
                completion(true)
            }
            else {
                print("error")
                completion(false)
            }
        }
        task.resume()
    }
    
    func getPokemonInfo(pokemonId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let request = ApiType.getPokemonInfo(id: String(pokemonId)).request
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(false)
                return
            }
            if let data = data, let pokemonInfo = try? JSONDecoder().decode(PokemonInfoApiModel.self, from: data) {
                pokemonInfo.store()
                completion(true)
            }
            else {
                print("error")
                completion(false)
            }
        }
        task.resume()
    }
}


extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

