//
//  FontLayout.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import Foundation
import UIKit

class FontLayout {
    static let regular14 : UIFont = UIFont(name: "HelveticaNeue-Regular", size: 14.0) ?? .systemFont(ofSize: 16, weight: .regular)
    static let medium14 : UIFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0) ?? .systemFont(ofSize: 16, weight: .medium)
    static let medium16: UIFont = UIFont(name: "HelveticaNeue-Medium", size: 16.0) ?? .systemFont(ofSize: 16, weight: .medium)
    static let medium20: UIFont = UIFont(name: "HelveticaNeue-Medium", size: 20.0) ?? .systemFont(ofSize: 20, weight: .medium)
    static let semibold20: UIFont = UIFont(name: "HelveticaNeue-Semibold", size: 20.0) ?? .systemFont(ofSize: 20, weight: .semibold)
    static let bold24: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 24.0) ?? .systemFont(ofSize: 24, weight: .bold)
    static let semibold24: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 24.0) ?? .systemFont(ofSize: 24, weight: .semibold)
    static let semibold28: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 28.0) ?? .systemFont(ofSize: 28, weight: .semibold)
}
