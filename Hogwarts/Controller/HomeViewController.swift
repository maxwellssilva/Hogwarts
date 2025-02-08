//
//  ViewController.swift
//  Hogwarts
//
//  Created by Maxwell da Silva e Silva on 30/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var characters: [ListCharacters] = []
    private var filterCharacters: [ListCharacters] = []
    private var isSearch = false
    
    //MARK: Componentes
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Procure por um personagem"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var list: UITableView = {
        let list = UITableView()
        list.backgroundColor = .blue
        list.dataSource = self
        list.delegate = self
        list.rowHeight = 90
        list.register(CardCell.self, forCellReuseIdentifier: "CardCell")
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()

    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        fetchCharacters()
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
        searchBar.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? filterCharacters.count : characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardCell else {
            return UITableViewCell()
        }
        let character = isSearch ? filterCharacters[indexPath.row] : characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearch = false
        } else {
            isSearch = true
            filterCharacters = characters.filter { character in
                return character.name.lowercased().contains(searchText.lowercased())
            }
        }
        list.reloadData()
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearch = false
        list.reloadData()
        searchBar.resignFirstResponder()
    }
}
