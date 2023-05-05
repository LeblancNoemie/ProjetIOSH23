//
//  Projet.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class aProjet : Codable {
    internal init(id: String, nom: String) {
        self.id = id
        self.nom = nom
    }
    var id : String
    var nom : String
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case nom
    }
    
}
