//
//  APIRequests.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import Foundation
import Alamofire

public protocol APIRequest {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    
}

public struct PokemonListRequest: APIRequest {
    public var endpoint: String = "\(APIService.baseUrl)/pokemon"
    
    public var method: HTTPMethod = .get
    
    public var parameters: Parameters?
    
    public init(offset: Int, limit: Int = 20){
        self.parameters = ["offset": offset*limit, "limit": limit ]
    }
}

public struct PokemonFormRequest: APIRequest{
    public var endpoint: String
    
    public var method: HTTPMethod = .get
    
    public var parameters: Parameters? = nil
    
    public init(endpoint: String){
        self.endpoint = endpoint
    }
}

public struct PokemonDetailRequest: APIRequest {
    public var endpoint: String = "\(APIService.baseUrl)/pokemon/"
    
    public var method: HTTPMethod = .get
    
    public var parameters: Parameters? = nil
    
    public init(pokemonName: String){
        self.endpoint = "\(APIService.baseUrl)/pokemon/\(pokemonName)"
    }
}

public struct PokemonAbilityRequest: APIRequest {
    public var endpoint: String
    
    public var method: HTTPMethod = .get
    
    public var parameters: Parameters? = nil
    
    public init(endpoint: String){
        self.endpoint = endpoint
    }
}
