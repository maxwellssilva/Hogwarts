//
//  ViewController.swift
//  Hogwarts
//
//  Created by Maxwell da Silva e Silva on 30/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var characters: [ListCharacters] = []
    
    //MARK: Componentes
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Procure por um personagem"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var list: UITableView = {
        let list = UITableView()
        list.backgroundColor = .blue
        list.dataSource = self
        list.delegate = self
        list.rowHeight = 70
        list.register(CardCell.self, forCellReuseIdentifier: "CardCell")
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()

    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Hogwarts"
    }
    
    //MARK: Métodos
    
    func fetchCharacters() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characters = characters
                    self?.list.reloadData()
                case .failure(let error):
                    print("Erro ao buscar personagens: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setupLayout() {
        view.addSubview(searchBar)
        view.addSubview(list)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            list.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            list.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = list.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardCell else {
            return UITableViewCell()
        }
        let character = characters[indexPath.row]
        //cell.configure(with: character)
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
