//
//  PokemonDetailViewModel.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import Foundation

class PokemonDetailViewModel {
    
    private var pokemonName: String
    
    init(pokemonName: String){
        self.pokemonName = pokemonName
    }
    
    private(set) var pokemonDetail: PokemonDetail?
    
    var onPokemonDetailFetch: (() -> Void) = {}
    var onError: ((Error) -> Void) = { error in }
    
    func fetchPokemonDetail(){
        let group = DispatchGroup()
        
        group.enter()
        let detailRequest = PokemonDetailRequest(pokemonName: self.pokemonName)
        APIService.shared.sendRequest(detailRequest, type: PokemonDetail.self) { result in
            switch result{
            case .success(let pokemon):
                self.pokemonDetail = pokemon
                if let typeUrl = pokemon.forms?.first?.url {
                    let formsRequest = PokemonFormRequest(endpoint: typeUrl)
                    group.enter()
                    APIService.shared.sendRequest(formsRequest, type: PokemonForms.self) { formResult in
                        switch formResult{
                        case .success(let forms):
                            self.pokemonDetail?.pokemonForms = forms
                        case .failure(let error):
                            self.onError(error)
                        }
                        group.leave()
                    }
                    
                    if let abilities = self.pokemonDetail?.abilities {
                        for item in abilities {
                            if let abilityUrl = item.ability?.url {
                                group.enter()
                                let abilityRequest = PokemonAbilityRequest(endpoint: abilityUrl)
                                APIService.shared.sendRequest(abilityRequest, type: PokemonAbility.self) { abilityResult in
                                    switch abilityResult {
                                    case .success(let ability):
                                        self.pokemonDetail?.pokemonAbilities.append(ability)
                                    case .failure(let error):
                                        print(error)
                                    }
                                    group.leave()
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                self.onError(error)
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.global()) {
            self.onPokemonDetailFetch()
        }
    }
}
