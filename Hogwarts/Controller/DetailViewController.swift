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
    
    private lazy var nameLabel = configLabel()
    private lazy var houseLabel = configLabel()
    private lazy var specieLabel = configLabel()
    private lazy var dateOfBirthLabel = configLabel()
    private lazy var patronusLabel = configLabel()
    private lazy var actorLabel = configLabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayoutDetail()

    }
    
    private func configLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        return label
    }
    
    func setupLayoutDetail() {
        view.addSubview(profile)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 15),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configure(with character: ListCharacters) {
        nameLabel.text = "Nome: \(character.name)"
        houseLabel.text = "Casa: \(character.house ?? "Desconhecida")"
        specieLabel.text = "Espécie: \(character.species ?? "Desconhecida")"
        dateOfBirthLabel.text = "Nascimento: \(character.dateOfBirth ?? "Não informado")"
        patronusLabel.text = "Patrono: \(character.patronus ?? "Não sabo")"
        actorLabel.text = "Ator: \(character.actor ?? "Desconhecido")"
        
        let placeholderImage = UIImage(named: "placeholder")
        
        if let imageUrl = character.image {
            profile.download(from: imageUrl, placeholder: placeholderImage)
        } else {
            profile.image = placeholderImage
        }
        
        switch character.house {
            case "Gryffindor":
                view.backgroundColor = .gryffindor
                nameLabel.textColor = .white
                houseLabel.textColor = .white
                specieLabel.textColor = .white
                dateOfBirthLabel.textColor = .white
                patronusLabel.textColor = .white
                actorLabel.textColor = .white
            case "Slytherin":
                view.backgroundColor = .slytherin
                nameLabel.textColor = .white
                houseLabel.textColor = .white
                specieLabel.textColor = .white
                dateOfBirthLabel.textColor = .white
                patronusLabel.textColor = .white
                actorLabel.textColor = .white
            case "Ravenclaw":
                view.backgroundColor = .ravenclaw
                nameLabel.textColor = .white
                houseLabel.textColor = .white
                specieLabel.textColor = .white
                dateOfBirthLabel.textColor = .white
                patronusLabel.textColor = .white
                actorLabel.textColor = .white
            case "Hufflepuff":
                view.backgroundColor = .hufflepuff
                nameLabel.textColor = .black
                houseLabel.textColor = .black
                specieLabel.textColor = .black
                dateOfBirthLabel.textColor = .black
                patronusLabel.textColor = .black
                actorLabel.textColor = .black
            default:
                view.backgroundColor = .systemBackground
                nameLabel.textColor = .label
        }
    }
}
