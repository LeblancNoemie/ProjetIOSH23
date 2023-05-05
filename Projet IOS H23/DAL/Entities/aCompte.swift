//
//  Compte.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class aCompte : Codable {
    internal init(id: Int, montant: Decimal, nom_banque: String) {
        self.id = id
        self.montant = montant
        self.nom_banque = nom_banque
    }
    
    
    var id: Int
    var montant: Decimal
    var nom_banque : String
    
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case montant
        case nom_banque
    }

    
}
