//
//  Convention.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class aConvention : Codable {
    /*
    internal init(id: String, date_fin: Date, fournisseur: String, prix: Double, type_convention: String, compteId: String, projetId: String) {
        self.id = id
        self.date_fin = date_fin
        self.fournisseur = fournisseur
        self.prix = prix
        self.type_convention = type_convention
        self.compteId = compteId
        self.projetId = projetId
    }
    */
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        do {
            self.date_fin = try container.decode(Date.self, forKey: .date_fin)
        } catch
        {
            let stringDate = try container.decode(String.self, forKey: .date_fin)
            
            let dateForm = DateFormatter()
            dateForm.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            
            self.date_fin = dateForm.date(from: stringDate)!
        }
        self.fournisseur = try container.decode(String.self, forKey: .fournisseur)
        self.prix = try container.decode(Double.self, forKey: .prix)
        self.type_convention = try container.decode(String.self, forKey: .type_convention)
        self.compteId = try container.decode(String.self, forKey: .compteId)
        self.projetId = try container.decode(String.self, forKey: .projetId)
    }
    
    var id: String
    var date_fin : Date
    var fournisseur: String
    var prix: Double
    var type_convention : String
    
    var compteId: String
    var projetId: String
    
    
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
