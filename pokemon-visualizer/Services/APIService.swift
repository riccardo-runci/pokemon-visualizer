//
//  PokemonService.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit
import Alamofire

class APIService {
    public static let shared = APIService()
    
    static let baseUrl = "https://pokeapi.co/api/v2"
    let baseImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork"
    
    func sendRequest<D: APIRequest,T>(_ request: D, type: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) where T: Decodable{
        AF.request(request.endpoint, method: request.method, parameters: request.parameters).responseJSON { response in
            if let error = response.error {
                completionHandler(.failure(error))
                return
            }
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completionHandler(.success(result))
                }
                catch{
                    print(error)
                    completionHandler(.failure(error))
                }
            }
            else{
                completionHandler(.failure(APIServiceError.noDataFound))
            }
        }
    }
    
    
}
