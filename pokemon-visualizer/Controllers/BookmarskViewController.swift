//
//  BookmarskViewController.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import UIKit

class BookmarskViewController: BaseViewController {
    var id: Int = 1
    let tableView: UITableView = {
        let tView = UITableView()
        tView.separatorStyle = .none
        return tView
    }()
    
    private var bookmarksViewModel: BookmarsViewModel!
    
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BookmarksManager.shared.addListener(self)
        self.bookmarksViewModel = BookmarsViewModel()
        self.bookmarksViewModel.onBookmarksSet = {
            self.refreshControl.endRefreshing()
            self.updateSource()
        }
        setupView()
        self.refreshControl.beginRefreshing()
        self.bookmarksViewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabDelegate.setTitle(title: "Bookmarks")
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
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.refreshControl.beginRefreshing()
        self.bookmarksViewModel.loadData()
    }
    
    deinit {
        BookmarksManager.shared.removeListener(self)
    }
}

extension BookmarskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookmarksViewModel.bookmarksList.count > 0 ? self.bookmarksViewModel.bookmarksList.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.bookmarksViewModel.bookmarksList.count == 0 {
            let titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.className, for: indexPath) as! TitleTableViewCell
            titleCell.setup(title: "You haven't added any pokemon to bookmarks yet")
            return titleCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftImageCaptionTableViewCell.className, for: indexPath) as! LeftImageCaptionTableViewCell
        let pokemon = self.bookmarksViewModel.bookmarksList[indexPath.row]
        cell.setup(imageUrl: pokemon.imageUrl, caption: pokemon.name?.capitalizingFirstLetter())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = self.bookmarksViewModel.bookmarksList[indexPath.row].name else {
            return
        }
        let vc = PokemonDetailViewController(pokemonDetailViewModel: PokemonDetailViewModel(pokemonName: name), listResult: self.bookmarksViewModel.bookmarksList[indexPath.row])
       // vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension BookmarskViewController: BookmarksListener {
    func bookmarksDidChange() {
        self.bookmarksViewModel.loadData()
    }
}
