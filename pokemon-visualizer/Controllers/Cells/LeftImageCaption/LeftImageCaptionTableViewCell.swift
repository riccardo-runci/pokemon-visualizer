//
//  PokemonListTableViewCell.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit

class LeftImageCaptionTableViewCell : UITableViewCell{

    let background: UIView = {
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        bView.backgroundColor = ColorLayout.defaultCellBackground
        bView.setShadowAndCorner(cornerRadius: 8)
        return bView
    }()
    
    let avatarView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        return iView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontLayout.medium16
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    func setup(imageUrl: String?, caption: String?){
        self.nameLabel.text = caption
        self.avatarView.setImageFromUrl(url: URL(string: imageUrl ?? ""), placeholder: ImageLayout.avatarPlaceholder)
    }
    
    private func setupView(){
        self.contentView.addSubview(background)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.background.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: ContentLayout.pokemonCellInsets.top).isActive = true
        self.background.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: ContentLayout.pokemonCellInsets.bottom).isActive = true
        self.background.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: ContentLayout.pokemonCellInsets.left).isActive = true
        self.background.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: ContentLayout.pokemonCellInsets.right).isActive = true
        
        self.background.addSubview(self.avatarView)
        self.avatarView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.avatarView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.avatarView.topAnchor.constraint(equalTo: self.background.topAnchor, constant: 8).isActive = true
        self.avatarView.leadingAnchor.constraint(equalTo: self.background.leadingAnchor, constant: 8).isActive = true
        self.avatarView.bottomAnchor.constraint(equalTo: self.background.bottomAnchor, constant: -8).isActive = true
        
        self.background.addSubview(self.nameLabel)

        self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.avatarView.topAnchor).isActive = true
        
        selectionStyle = .none
    }
}
