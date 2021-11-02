//
//  TitleTableViewCell.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import UIKit

class TitleTableViewCell :UITableViewCell {
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = FontLayout.medium16
        label.textAlignment = .left
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    func setup(title: String?){
        self.leftLabel.text = title
    }

    private func setupView(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear

        self.addSubview(leftLabel)
        leftLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ContentLayout.defaultCellInsets.right).isActive = true
        leftLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ContentLayout.defaultCellInsets.top).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ContentLayout.defaultCellInsets.left).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ContentLayout.defaultCellInsets.bottom).isActive = true

    }
}

