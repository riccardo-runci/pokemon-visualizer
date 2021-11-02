//
//  BookmarsViewModel.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import Foundation

class BookmarsViewModel {
    private(set) var bookmarksList: [PokemonListResult] = [] {
        didSet{
            self.onBookmarksSet()
        }
    }
    
    var onBookmarksSet: (() -> Void) = {}
    
    func loadData(){
        self.bookmarksList = BookmarksManager.shared.getBookmarks()
    }
}
