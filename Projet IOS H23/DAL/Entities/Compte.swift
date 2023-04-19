//
//  Compte.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class Compte : Codable {
    internal init(id: Int, montant: Decimal, type_depense: String) {
        self.id = id
        self.montant = montant
        self.type_depense = type_depense
    }
    
    
    var id: Int
    var montant: Decimal
    var type_depense : String
    
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case montant
        case nom_banque
    }

    
}
