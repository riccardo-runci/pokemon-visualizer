//
//  PokemonStatsCell.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit

class RightTitleLeftCaptionTableViewCell : UITableViewCell{

    let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = FontLayout.medium16
        label.textAlignment = .left
        return label
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = FontLayout.regular14
        label.textAlignment = .right
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    func setup(rightText: String?, leftText: String?){
        self.rightLabel.text = rightText
        self.leftLabel.text = leftText
    }
    
    private func setupView(){
        self.addSubview(rightLabel)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        rightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ContentLayout.defaultCellInsets.left).isActive = true
        rightLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ContentLayout.defaultCellInsets.top).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ContentLayout.defaultCellInsets.bottom).isActive = true
       // rightLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(leftLabel)
        leftLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ContentLayout.defaultCellInsets.right).isActive = true
        leftLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ContentLayout.defaultCellInsets.top).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: rightLabel.trailingAnchor).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ContentLayout.defaultCellInsets.bottom).isActive = true
        
        rightLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        rightLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

