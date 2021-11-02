//
//  ContentLayout.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 27/10/21.
//

import UIKit

class ContentLayout {
    static let defaultCellInsets = UIEdgeInsets(top: 8, left: 30, bottom: -8, right: -30)
    static let pokemonCellInsets = UIEdgeInsets(top: 15, left: 30, bottom: -15, right: -30)
    
    static var topInset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    static var bottomInset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
}
