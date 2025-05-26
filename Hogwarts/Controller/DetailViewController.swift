//
//  DetailViewController.swift
//  Hogwarts
//
//  Created by Maxwell Silva on 08/02/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var profile: UIImageView = {
        let profile = UIImageView()
        profile.layer.cornerRadius = 8
        profile.contentMode = .scaleAspectFill
        profile.clipsToBounds = true
        profile.heightAnchor.constraint(equalToConstant: 250).isActive = true
        profile.widthAnchor.constraint(equalToConstant: 220).isActive = true
        profile.translatesAutoresizingMaskIntoConstraints = false
        return profile
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, houseLabel, specieLabel,
                                                   dateOfBirthLabel, patronusLabel, actorLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        name.textColor = .label
        return name
    }()
    
    private lazy var houseLabel: UILabel = {
        let house = UILabel()
        house.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        house.textColor = .label
        return house
    }()
    
    private lazy var specieLabel: UILabel = {
        let specie = UILabel()
        specie.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        specie.textColor = .label
        return specie
    }()
    
    private lazy var dateOfBirthLabel: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        date.textColor = .label
        return date
    }()
    
    private lazy var patronusLabel: UILabel = {
        let patronus = UILabel()
        patronus.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        patronus.textColor = .label
        return patronus
    }()
    
    private lazy var actorLabel: UILabel = {
        let actor = UILabel()
        actor.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        actor.textColor = .label
        actor.numberOfLines = 0
        return actor
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayoutDetail()

    }
    
    func setupLayoutDetail() {
        view.addSubview(profile)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with character: ListCharacters) {
        nameLabel.text = "Nome: \(character.name)"
        houseLabel.text = "Casa: \(character.house ?? "Desconhecida")"
        specieLabel.text = "Espécie: \(character.species ?? "Desconhecida")"
        dateOfBirthLabel.text = "Nascimento: \(character.dateOfBirth ?? "Não informado")"
        patronusLabel.text = "Patrono: \(character.patronus ?? "Nenhum")"
        actorLabel.text = "Ator: \(character.actor ?? "Desconhecido")"
        
        let placeholderImage = UIImage(named: "placeholder")
        
        if let imageUrl = character.image {
            profile.download(from: imageUrl, placeholder: placeholderImage)
        } else {
            profile.image = placeholderImage
        }
    }
}
