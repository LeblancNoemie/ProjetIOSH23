//
//  Convention.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class aConvention : Codable {
    internal init(id: Int, date_fin: Date, fournisseur: String, prix: Decimal, type_convention: String, compteId: Int, projetId: Int) {
        self.id = id
        self.date_fin = date_fin
        self.fournisseur = fournisseur
        self.prix = prix
        self.type_convention = type_convention
        self.compteId = compteId
        self.projetId = projetId
    }
    
    
    var id: Int
    var date_fin : Date
    var fournisseur: String
    var prix: Decimal
    var type_convention : String
    
    var compteId: Int
    var projetId: Int
    
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case date_fin
        case fournisseur
        case prix
        case type_convention
        case compteId
        case projetId
    }

}
