//
//  Depense.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-04-19.
//

import Foundation
class aDepense  : Codable {
    /*internal init(id: String, date_paiement: Date, mode_paiement: String, prix: Double, type_depense: String, compteId: String, projetId: String) {
        self.id = id
        //self.date_paiement = date_paiement
        self.mode_paiement = mode_paiement
        self.prix = prix
        self.type_depense = type_depense
        self.compteId = compteId
        self.projetId = projetId
        
    }*/
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        do{
            self.date_paiement = try container.decode(Date.self, forKey: .date_paiement)
        } catch
        {
            let stringDate = try container.decode(String.self, forKey: .date_paiement)
            
            let dateForm = DateFormatter()
            dateForm.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            
            self.date_paiement = dateForm.date(from: stringDate)!
        }
        self.mode_paiement = try container.decode(String.self, forKey: .mode_paiement)
        self.prix = try container.decode(Double.self, forKey: .prix)
        self.type_depense = try container.decode(String.self, forKey: .type_depense)
        self.compteId = try container.decode(String.self, forKey: .compteId)
        self.projetId = try container.decode(String.self, forKey: .projetId)
    }
    
    var id: String
    var date_paiement : Date
    var mode_paiement: String
    var prix: Double
    var type_depense : String
    
    var compteId: String
    var projetId: String
    
    
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
