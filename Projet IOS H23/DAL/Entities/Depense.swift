//
//  Depense.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class Depense  : Codable {
    internal init(id: Int, date_paiement: Date, mode_paiement: String, prix: Decimal, type_depense: String, compteId: Int, projetId: Int) {
        self.id = id
        self.date_paiement = date_paiement
        self.mode_paiement = mode_paiement
        self.prix = prix
        self.type_depense = type_depense
        self.compteId = compteId
        self.projetId = projetId
    }
    
    var id: Int
    var date_paiement : Date
    var mode_paiement: String
    var prix: Decimal
    var type_depense : String
    
    var compteId: Int
    var projetId: Int
    
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case date_paiement
        case mode_paiement
        case prix
        case type_depense
        case compteId
        case projetId
    }

    
}
