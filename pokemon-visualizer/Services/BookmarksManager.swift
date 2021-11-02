//
//  BookmarksManager.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import Foundation

class BookmarksManager {
    static let shared = BookmarksManager()
    
    private var listeners: [BookmarksListener] = []
    
    func addListener(_ listener: BookmarksListener) {
        if listeners.contains(where: { $0.id == listener.id }) { return }
        listeners.append(listener)
    }
    
    func removeListener(_ listener: BookmarksListener) {
        listeners.removeAll(where: { $0.id == listener.id })
    }
    
    func saveToBookmark(pokemon: PokemonListResult){
        if self.checkBookmarksCointain(pokemon){
            return
        }
        var bookmarks = self.getBookmarks()
        bookmarks.append(pokemon)
        self.serializeToUserDefaults(bookmarks)
    }
    
    func removeBookmark(pokemon: PokemonListResult){
        var bookmarks = self.getBookmarks()
        bookmarks.removeAll(where: { $0.name == pokemon.name })
        self.serializeToUserDefaults(bookmarks)
    }
    
    func getBookmarks() -> [PokemonListResult]{
        do {
            if let jsonString = UserDefaults.standard.string(forKey: "bookmarks")?.data(using: .utf8) {
                let result = try JSONDecoder().decode([PokemonListResult].self, from: jsonString)
                return result
            }
        }
        catch{
            print(error)
        }
        
        return []
    }
    
    func checkBookmarksCointain(_ pokemon: PokemonListResult) -> Bool {
        return self.getBookmarks().first(where: { $0.name == pokemon.name }) != nil
    }
    
    private func serializeToUserDefaults(_ pokemons: [PokemonListResult]){
        do {
            let result = try JSONEncoder().encode(pokemons)
            let resultString = String(data: result, encoding: .utf8)
            UserDefaults.standard.set(resultString, forKey: "bookmarks")
            UserDefaults.standard.synchronize()
            self.listeners.forEach({ $0.bookmarksDidChange() })
        }
        catch {
            print(error)
        }
    }
}

protocol BookmarksListener: AnyObject {
    var id: Int {get set}
    func bookmarksDidChange()
}
