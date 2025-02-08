//
//  CardCell.swift
//  Hogwarts
//
//  Created by Maxwell Silva on 07/02/25.
//

import UIKit

class CardCell: UITableViewCell {
    
    private lazy var imageCharacter: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.heightAnchor.constraint(equalToConstant: 120).isActive = true
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)
        name.textColor = .label
        name.numberOfLines = 0
        return name
    }()
    
    private lazy var houseLabel: UILabel = {
        let house = UILabel()
        house.font = UIFont(name: "HelveticaNeue", size: 15)
        //house.textColor = .label
        return house
    }()
    
    private lazy var iconImage: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return icon
    }()
    
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, houseLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackHorizontal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImage, stackVertical])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: Inicializador
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCardCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCardCell() {
        addSubview(imageCharacter)
        addSubview(stackHorizontal)
        NSLayoutConstraint.activate([
            imageCharacter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageCharacter.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackHorizontal.leadingAnchor.constraint(equalTo: imageCharacter.trailingAnchor, constant: 20),
            stackHorizontal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackHorizontal.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configure(with character: ListCharacters) {
        nameLabel.text = character.name
        houseLabel.text = character.house
        
        let placeholderImage = UIImage(named: "placeholder")
        
        imageCharacter.image = placeholderImage
        
        if let imageUrl = character.image {
            //print("Carregando imagem: \(imageUrl)")
            imageCharacter.download(from: imageUrl, placeholder: placeholderImage)
        }
        
        switch character.house {
            case "Gryffindor":
                houseLabel.textColor = UIColor(named: "GryffindorColor")
                iconImage.image = UIImage(named: "gryffindor")
            case "Slytherin":
                houseLabel.textColor = UIColor(named: "SlytherinColor")
                iconImage.image = UIImage(named: "slytherin")
            case "Ravenclaw":
                houseLabel.textColor = UIColor(named: "RavenclawColor")
                iconImage.image = UIImage(named: "ravenclaw")
            case "Hufflepuff":
                houseLabel.textColor = UIColor(named: "HufflepuffColor")
                iconImage.image = UIImage(named: "hufflepuff")
            default:
                backgroundColor = .systemBackground
        }
    }
}
