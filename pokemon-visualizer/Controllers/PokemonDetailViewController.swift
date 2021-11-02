//
//  PokemonDetailViewController.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    enum Sections: Int {
        case stats = 0
        case abilities = 1
        case allSections = 2
    }
    
    
    private var pokemonDetailViewModel: PokemonDetailViewModel!
    private var pokemonListResult: PokemonListResult!
    
    let headerView: UIView = {
        let hView = UIView()
        hView.translatesAutoresizingMaskIntoConstraints = false
        hView.backgroundColor = ColorLayout.defaultCellBackground
        hView.setShadowAndCorner(cornerRadius: 8)
        return hView
    }()
    
    let tableView: UITableView = {
        let tView = UITableView()
        return tView
    }()
    
    let avatarView: UIImageView = {
        let aView = UIImageView()
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    let nameLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.translatesAutoresizingMaskIntoConstraints = false
        nLabel.textAlignment = .center
        nLabel.font = FontLayout.semibold28
        return nLabel
    }()
    
    let specieLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.translatesAutoresizingMaskIntoConstraints = false
        nLabel.textAlignment = .center
        nLabel.font = FontLayout.medium20
        nLabel.text = "Type\n- - -"
        nLabel.numberOfLines = 0
        return nLabel
    }()
    
    let heightLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.translatesAutoresizingMaskIntoConstraints = false
        nLabel.textAlignment = .center
        nLabel.font = FontLayout.medium20
        nLabel.text = ""
        nLabel.numberOfLines = 0
        return nLabel
    }()
    
    let weightLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.translatesAutoresizingMaskIntoConstraints = false
        nLabel.textAlignment = .center
        nLabel.font = FontLayout.medium20
        nLabel.text = ""
        nLabel.numberOfLines = 0
        return nLabel
    }()
    
    let coseButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "bookmark_icon"), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    let progressView: UIProgressView = {
        let pView = UIProgressView()
        pView.translatesAutoresizingMaskIntoConstraints = false
        pView.progressTintColor = .green
        pView.progressTintColor = .systemGreen
        return pView
    }()
    
    let hpLabel: UILabel = {
        let nLabel = UILabel()
        nLabel.translatesAutoresizingMaskIntoConstraints = false
        nLabel.textAlignment = .center
        nLabel.font = FontLayout.regular14
        nLabel.text = ""
        nLabel.numberOfLines = 1
        return nLabel
    }()
    
    init(pokemonDetailViewModel: PokemonDetailViewModel, listResult: PokemonListResult){
        super.init(nibName: nil, bundle: nil)
        self.pokemonDetailViewModel = pokemonDetailViewModel
        self.pokemonListResult = listResult
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
        self.pokemonDetailViewModel.onPokemonDetailFetch = {
            DispatchQueue.main.async {
                self.loadingIndicator.isHidden = true
                guard let pokemonDetail = self.pokemonDetailViewModel.pokemonDetail else {
                    return
                }
                self.setupView(pokemonDetail: pokemonDetail)
            }
        }
        loadingIndicator.isHidden = false
        self.pokemonDetailViewModel.fetchPokemonDetail()
    }
    
    func buildView(){
        self.view.backgroundColor = ColorLayout.defaultBackground
        
        self.view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        self.headerView.addSubview(heightLabel)
        heightLabel.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -25).isActive = true
        heightLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -15).isActive = true
        
        self.headerView.addSubview(weightLabel)
        weightLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 25).isActive = true
        weightLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -15).isActive = true
        
        self.headerView.addSubview(specieLabel)
        specieLabel.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor).isActive = true
        specieLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -15).isActive = true
        specieLabel.leadingAnchor.constraint(equalTo: self.weightLabel.trailingAnchor).isActive = true
        specieLabel.trailingAnchor.constraint(equalTo: self.heightLabel.leadingAnchor).isActive = true
        specieLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        specieLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        self.headerView.addSubview(coseButton)
        coseButton.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 30).isActive = true
        coseButton.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 30).isActive = true
        coseButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        self.headerView.addSubview(bookmarkButton)
        bookmarkButton.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 30).isActive = true
        bookmarkButton.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -30).isActive = true
        bookmarkButton.addTarget(self, action: #selector(addToBookmarkAction), for: .touchUpInside)
        
        self.headerView.addSubview(avatarView)
        avatarView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor, constant: 0).isActive = true
        avatarView.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 24).isActive = true
        
        self.headerView.addSubview(loadingIndicator)
        loadingIndicator.topAnchor.constraint(equalTo: avatarView.topAnchor).isActive = true
        loadingIndicator.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor).isActive = true
        loadingIndicator.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor).isActive = true
        loadingIndicator.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor).isActive = true
        
        self.headerView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 24).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 12).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -24).isActive = true
        
        self.headerView.addSubview(progressView)
        progressView.trailingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 20).isActive = true
        progressView.leadingAnchor.constraint(equalTo: self.avatarView.leadingAnchor, constant: -20).isActive = true
        progressView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 14).isActive = true
        //progressView.bottomAnchor.constraint(equalTo: specieLabel.topAnchor, constant: -14).isActive = true
        
        self.headerView.addSubview(hpLabel)
        hpLabel.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor).isActive = true
        hpLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 8).isActive = true
        hpLabel.bottomAnchor.constraint(equalTo: specieLabel.topAnchor, constant: -14).isActive = true
        
        self.view.addSubview(self.tableView)
        self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 15).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.setupView(self)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        self.view.bringSubviewToFront(headerView)
    }

    @objc func closeAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addToBookmarkAction(sender: UIButton!) {
        if BookmarksManager.shared.checkBookmarksCointain(self.pokemonListResult){
            BookmarksManager.shared.removeBookmark(pokemon: self.pokemonListResult)
        }
        else{
            BookmarksManager.shared.saveToBookmark(pokemon: self.pokemonListResult)
        }
        self.setupBookmarkIcon()
    }
    
    func setupView(pokemonDetail: PokemonDetail){
        self.avatarView.setImageFromUrl(url: pokemonDetail.imageUrl, placeholder: ImageLayout.avatarPlaceholder)
        self.nameLabel.text = pokemonDetail.name?.capitalizingFirstLetter()
        if let hp = pokemonDetail.stats?.first(where: { $0.stat?.name == "hp"})?.baseStat {
            self.progressView.progress = 1
            self.hpLabel.text = "HP \(hp)/\(hp)"
        }
        #warning("Height and weight of the pokemon must be formatted to m/kg, but the response format are unknown")
        if let height = pokemonDetail.height {
            self.heightLabel.text = "Height\n\(height) m"
        }
        if let weight = pokemonDetail.weight {
            self.weightLabel.text = "Weight\n\(weight) kg"
        }
        if let formsRaw = pokemonDetail.pokemonForms?.types, formsRaw.count > 0 {
            let forms = formsRaw.map({ $0.type?.name?.capitalizingFirstLetter() ?? "" })
            let text = "Type\n" + forms.joined(separator: " - ")
            self.specieLabel.text = text
        }
        self.setupBookmarkIcon()
        self.tableView.reloadData()
    }
    
    func setupBookmarkIcon(){
        self.bookmarkButton.tintColor = BookmarksManager.shared.checkBookmarksCointain(self.pokemonListResult) ? .systemYellow : .lightGray
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiView = UIView()
        let titleLabel = UILabel()
        uiView.addSubview(titleLabel)
        uiView.backgroundColor = ColorLayout.defaultBackground
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: uiView.centerXAnchor).isActive = true
        titleLabel.font = FontLayout.semibold20
        if section == Sections.stats.rawValue {
            titleLabel.text = "Stats"
        }
        else if section == Sections.abilities.rawValue {
            titleLabel.text = "Abilities"
        }
        return uiView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allSections.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pokemonDetailViewModel.pokemonDetail == nil {
            return 0
        }
        if section == Sections.stats.rawValue {
            return self.pokemonDetailViewModel.pokemonDetail?.stats?.count ?? 0
        }
        if section == Sections.abilities.rawValue{
            return self.pokemonDetailViewModel.pokemonDetail?.abilities?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Sections.stats.rawValue {
            let statCell = tableView.dequeueReusableCell(withIdentifier: RightTitleLeftCaptionTableViewCell.className, for: indexPath) as! RightTitleLeftCaptionTableViewCell
            statCell.setup(rightText: self.pokemonDetailViewModel.pokemonDetail?.stats?[indexPath.row].stat?.name?.replacingOccurrences(of: "-", with: " ").capitalizingFirstLetter(), leftText: String(self.pokemonDetailViewModel.pokemonDetail?.stats?[indexPath.row].baseStat ?? 0))
            statCell.selectionStyle = .none
            return statCell
        }
        else if indexPath.section == Sections.abilities.rawValue {
            let statCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.className, for: indexPath) as! TitleTableViewCell
            statCell.setup(title: self.pokemonDetailViewModel.pokemonDetail?.abilities?[indexPath.row].ability?.name?.replacingOccurrences(of: "-", with: " ").capitalizingFirstLetter())
            statCell.selectionStyle = .none
            return statCell
        }
        let statCell = tableView.dequeueReusableCell(withIdentifier: RightTitleLeftCaptionTableViewCell.className, for: indexPath) as! RightTitleLeftCaptionTableViewCell
        return statCell
    }
}
