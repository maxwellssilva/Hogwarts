//
//  CardCell.swift
//  Hogwarts
//
//  Created by Maxwell Silva on 22/01/25.
//

import UIKit

class CardCell: UITableViewCell {
    
    lazy var personImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.backgroundColor = .systemYellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var personName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.adjustsFontSizeToFitWidth = true
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupCardCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: Toma cachorro) has not been implemented")
    }
    
    func setupCardCell() {
        addSubview(personImage)
        addSubview(personName)
        NSLayoutConstraint.activate([
            personImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            personImage.heightAnchor.constraint(equalToConstant: 80),
            personImage.widthAnchor.constraint(equalTo: personImage.heightAnchor),
            
            personName.centerYAnchor.constraint(equalTo: centerYAnchor),
            personName.leadingAnchor.constraint(equalTo: personImage.leadingAnchor, constant: 15),
            personName.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
