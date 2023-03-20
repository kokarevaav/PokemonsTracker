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

struct ResponseModel {
    let statusCode : Int
    let error : Error?
    let data : Data?
}

class ApiManager {
    static let shared = ApiManager()
    
    func getPokemonList(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let request = ApiType.getPokemonList.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error -> Void in
            if let data = data, let pokemonList = try? JSONDecoder().decode(PokemonListApiModel<[Result]>.self, from: data) {
                DispatchQueue.main.async {
                    CoreDataManager.shared.resetAllRecords(in: "PokemonList")
                }
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
    
    func getPokemonInfo(pokemonId: Int, completion: @escaping () -> Void) {
        let request = ApiType.getPokemonInfo(id: String(pokemonId)).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let pokemonInfo = try? JSONDecoder().decode(PokemonInfoApiModel.self, from: data) {
                pokemonInfo.store()
                completion()
            }
            else {
                print("error")
                completion()
            }
        }
        task.resume()
    }
}

