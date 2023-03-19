//
//  DepenseDAO.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import Foundation
class DepenseDAO {
    static var shared = DepenseDAO()
    
    func getByModePaiement(mode_paiement: String) -> [Depense] {
        return DepensesDataManager.shared.getAllByModePaiement(payment_mode: mode_paiement)
    }
    
    func getByNomProjet(project_name: String) -> [Depense] {
        return DepensesDataManager.shared.getAllByProjectName(projectName: project_name)
    }
    
    func getTotalDepenses(project_name:String) -> Double{
        var res : Double = 0.00
        for depense in DepensesDataManager.shared.getAllByProjectName(projectName: project_name){
            res += depense.prix as! Double
        }
        return res
        
    }
}
