import Foundation

enum ApiType {
    case getPokemonList
    case getPokemonInfo(id: String)
    
    var baseURL: String {
        return "https://pokeapi.co/api/v2/pokemon"
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var path: String {
        switch self {
        case .getPokemonList: return self.baseURL
        case .getPokemonInfo(let id): return "/\(id)/ "
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

class ApiManager {
    static let shared = ApiManager()
    
    func getPokemonList(completion: @escaping (PokemonList) -> Void) {
        let request = ApiType.getPokemonList.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let pokemonList = try? JSONDecoder().decode(PokemonList.self, from: data) {
                print(pokemonList.results?.first?.name)
            }
        }
        task.resume()
    }
}
