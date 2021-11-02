//
//  UITableView+Extensions.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit

extension UITableView {
    
    func setupView<T>(_ fromView: T) where T: UITableViewDataSource, T: UITableViewDelegate, T: UIViewController {
        self.delegate = fromView
        self.dataSource = fromView
        self.translatesAutoresizingMaskIntoConstraints = false
        self.estimatedRowHeight = 50
        self.rowHeight = UITableView.automaticDimension
        self.backgroundColor = .clear
        self.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        self.separatorStyle = .none
        self.register(cellType: RightTitleLeftCaptionTableViewCell.self)
        self.register(cellType: LeftImageCaptionTableViewCell.self)
        self.register(cellType: TitleTableViewCell.self)
    }
    
    func register(cellType cell: UITableViewCell.Type) {
        self.register(cell, forCellReuseIdentifier: cell.className)
    }
}
