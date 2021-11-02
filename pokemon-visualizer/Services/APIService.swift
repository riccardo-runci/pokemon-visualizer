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
        if let cachedResponse = Cache.shared.getCachedResponse(request.getRequestUrl())?.data(using: .utf8){
            do{
                let result = try JSONDecoder().decode(type.self, from: cachedResponse)
                completionHandler(.success(result))
                return
            }
            catch{
                print(error)
            }
        }
        AF.request(request.getRequestUrl(), method: request.method).responseJSON { response in
            if let error = response.error {
                completionHandler(.failure(error))
                return
            }
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completionHandler(.success(result))
                    if let response = String(data: data, encoding: .utf8){
                        Cache.shared.saveToCache(request.getRequestUrl(), response)
                    }
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
