//
//  UIView+Extensions.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit

extension UIView {
    
    func setShadowAndCorner(cornerRadius: CGFloat){
        self.layer.masksToBounds = false
        self.layer.shadowColor = ColorLayout.defaultShadow.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = cornerRadius
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    func constraintTo(view: UIView, top: CGFloat? = nil, bottom: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, centerX: CGFloat? = nil, centerY: CGFloat? = nil){
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        }
    }
}
