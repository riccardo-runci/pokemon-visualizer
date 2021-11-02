//
//  String+Extensions.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
