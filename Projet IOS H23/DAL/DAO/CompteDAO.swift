//
//  CompteDAO.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-19.
//

import Foundation
class CompteDAO{
    static var shared = CompteDAO()
    
    func getByName(bank_name: String) -> Compte {
        return ComptesDataManager.shared.getCompteByName(name: bank_name)
    }
}
