//
//  PokemonListViewController.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit

class PokemonListViewController: BaseViewController {
    let tableView: UITableView = {
        let tView = UITableView()
        if #available(iOS 13.0, *) {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tView.bounds.width, height: CGFloat(44))
            tView.tableFooterView = spinner
        } else {
            let spinner = UIActivityIndicatorView()
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tView.bounds.width, height: CGFloat(44))
            tView.tableFooterView = spinner
        }

        tView.tableFooterView?.isHidden = true
        
        tView.separatorStyle = .none
        return tView
    }()
    
    
    private var pokemonListViewModel: PokemonListViewModel!
    
    private var loadingData: Bool = false
    
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.pokemonListViewModel = PokemonListViewModel()
        self.pokemonListViewModel.onPokemonListSet = {
            self.refreshControl.endRefreshing()
            self.updateSource()
        }
        self.pokemonListViewModel.onError = { error in
            self.refreshControl.endRefreshing()
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.refreshControl.beginRefreshing()
                    self.pokemonListViewModel.loadData()
                }
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        setupView()
        self.refreshControl.beginRefreshing()
        self.pokemonListViewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabDelegate.setTitle(title: "Pokemons")
    }
    
    private func setupView(){
        self.view.backgroundColor = ColorLayout.defaultBackground
        
        self.view.addSubview(tableView)
        tableView.setupView(self)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Loading data")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        setupConstraints()
    }
    
    
    private func setupConstraints(){
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func updateSource(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingData = false
            self.tableView.tableFooterView?.isHidden = true
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.refreshControl.beginRefreshing()
        self.pokemonListViewModel.loadData()
    }
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonListViewModel.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftImageCaptionTableViewCell.className, for: indexPath) as! LeftImageCaptionTableViewCell
        let pokemon = self.pokemonListViewModel.pokemonList[indexPath.row]
        cell.setup(imageUrl: pokemon.imageUrl, caption: pokemon.name?.capitalizingFirstLetter())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.pokemonListViewModel.pokemonList.count - 1
        if !loadingData && indexPath.row == lastElement {
            self.tableView.tableFooterView?.isHidden = false
            loadingData = true
            self.pokemonListViewModel.fetchPokemonListData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = self.pokemonListViewModel.pokemonList[indexPath.row].name else {
            return
        }
        let vc = PokemonDetailViewController(pokemonDetailViewModel: PokemonDetailViewModel(pokemonName: name), listResult: self.pokemonListViewModel.pokemonList[indexPath.row])
       // vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
