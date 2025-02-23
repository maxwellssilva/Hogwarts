//
//  Characters.swift
//  Hogwarts
//
//  Created by Maxwell Silva on 07/02/25.
//

import UIKit

struct ListCharacters: Codable {
    let name: String
    let image: String?
    let house: String?
    let species: String?
    let dateOfBirth: String?
    let patronus: String?
    let actor: String?
}
