//
//  TabViewController.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 28/10/21.
//

import UIKit

class TabViewController: UIViewController {
    lazy var controllers = [PokemonListViewController(), BookmarskViewController()]
    
    private let tabButtonWidth: CGFloat = 34
    
    let containerView: UIView = {
        let uView = UIView()
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.backgroundColor = .clear
        return uView
    }()
    
    let mainNavigationController: UINavigationController = {
        let navVc = UINavigationController()
        navVc.view.translatesAutoresizingMaskIntoConstraints = false
        return navVc
    }()
    
    let tabView: UIView = {
        let uView = UIView()
        uView.translatesAutoresizingMaskIntoConstraints = false
        uView.backgroundColor = ColorLayout.defaultCellBackground
        uView.setShadowAndCorner(cornerRadius: 8)
        return uView
    }()
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "home_icon"), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "bookmark_icon"), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        return button
    }()
    
    let headerView: UIView = {
        let hView = UIView()
        hView.translatesAutoresizingMaskIntoConstraints = false
        hView.backgroundColor = ColorLayout.defaultCellBackground
        hView.setShadowAndCorner(cornerRadius: 8)
        return hView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = FontLayout.semibold20
        titleLabel.text = ""
        return titleLabel
    }()
    
    var tabButtons: [UIButton] = []
    
    private var currentViewIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView(){
        self.view.backgroundColor = .clear
        self.tabButtons = [homeButton, bookmarkButton]
        setupContainer()
        self.setViewController(index: 0)
    }
    
    
    private func setupHeader(){
        self.view.addSubview(self.headerView)
        self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        let topMargin = ContentLayout.topInset + 60
        self.headerView.heightAnchor.constraint(equalToConstant: topMargin).isActive = true
        self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.headerView.addSubview(self.titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 12).isActive = true
    }
    
    func setupContainer(){
        self.setupHeader()
        self.view.addSubview(tabView)
        tabView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tabView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        let bottomMargin = ContentLayout.bottomInset + 80
        tabView.heightAnchor.constraint(equalToConstant: bottomMargin).isActive = true
        
        self.tabView.addSubview(self.homeButton)
        homeButton.centerYAnchor.constraint(equalTo: self.tabView.centerYAnchor).isActive = true
        homeButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        homeButton.heightAnchor.constraint(equalToConstant: self.tabButtonWidth).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: self.tabButtonWidth).isActive = true
        
        self.tabView.addSubview(self.bookmarkButton)
        bookmarkButton.centerYAnchor.constraint(equalTo: self.tabView.centerYAnchor).isActive = true
        bookmarkButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        bookmarkButton.heightAnchor.constraint(equalToConstant: self.tabButtonWidth).isActive = true
        bookmarkButton.widthAnchor.constraint(equalToConstant: self.tabButtonWidth).isActive = true
        
        let distance = (UIScreen.main.bounds.width - (CGFloat(self.tabButtons.count) * self.tabButtonWidth)) / 3
        homeButton.leadingAnchor.constraint(equalTo: self.tabView.leadingAnchor, constant: distance).isActive = true
        bookmarkButton.leadingAnchor.constraint(equalTo: self.homeButton.trailingAnchor, constant: distance).isActive = true
        
        
        self.view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.tabView.topAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.view.bringSubviewToFront(tabView)
        self.view.bringSubviewToFront(headerView)
    }
    
    func setViewController(index: Int){
        self.controllers[currentViewIndex].willMove(toParent: nil)
        self.controllers[currentViewIndex].removeFromParent()
        self.controllers[currentViewIndex].view.removeFromSuperview()
        
        for (i, item) in self.tabButtons.enumerated() {
            item.tintColor = i == index ? .systemBlue : .lightGray
        }
        self.view.layoutIfNeeded()
        self.view.setNeedsLayout()
        let child = self.controllers[index]
        child.tabDelegate = self
        self.containerView.addSubview(child.view)
        self.addChild(child)
        child.view.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        child.view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        child.view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        // MARK: workaround to avoid breaking constraint errors
        child.view.frame = CGRect(x: child.view.frame.minX, y: child.view.frame.minY, width: child.view.frame.width, height: self.containerView.frame.height)
        child.didMove(toParent: self)
        self.currentViewIndex = index
    }
    
    @objc func tapAction(sender: UIButton!) {
        self.setViewController(index: sender.tag)
    }
}

extension TabViewController: TabViewDelegate {
    func setTitle(title: String) {
        UIView.transition(with: self.titleLabel, duration: 0.25, options: .transitionCrossDissolve, animations: { [weak self] in self?.titleLabel.text = title
        }, completion: nil)
    }
}

protocol TabViewDelegate {
    func setTitle(title: String)
}
