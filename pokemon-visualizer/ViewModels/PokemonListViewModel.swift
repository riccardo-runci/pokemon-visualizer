//
//  PokemonListViewModel.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import Foundation

class PokemonListViewModel {
    
    private(set) var pokemonList: [PokemonListResult] = [] {
        didSet{
            self.onPokemonListSet()
        }
    }
    
    var onPokemonListSet: (() -> Void) = {}
    var onError: ((Error) -> Void) = { error in }
    private var offsetCount = 0
    
    func loadData(){
        self.offsetCount = 0
        self.fetchPokemonListData()
    }
    
    func fetchPokemonListData(){
        let request = PokemonListRequest(offset: offsetCount)
        APIService.shared.sendRequest(request, type: PokemonList.self) { result in
            switch result {
            case .success(let list):
                self.pokemonList.append(contentsOf: list.results)
                self.offsetCount += 1
            case .failure(let error):
                print(error)
                self.onError(error)
            }
        }
    }
}
