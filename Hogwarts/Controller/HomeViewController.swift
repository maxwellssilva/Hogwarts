//
//  ViewController.swift
//  Hogwarts
//
//  Created by Maxwell da Silva e Silva on 30/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Componentes
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Pesquise um personagem"
        searchBar.searchBarStyle = .default
        searchBar.tintColor = .systemBlue
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var listPerson: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cyan
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHomeScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Hogwarts"
    }

    //MARK: Métodos
    func setupHomeScreen() {
        view.addSubview(searchBar)
        view.addSubview(listPerson)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            listPerson.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            listPerson.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listPerson.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listPerson.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CardCell()
    }
    
    
}
