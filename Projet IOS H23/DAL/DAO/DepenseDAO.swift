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
    
    func getProjectUpcomingPayments(project_name: String) -> [Depense] {
        var res : [Depense] = []
        for depense in getByNomProjet(project_name: project_name){
            if depense.mode_paiement == "Cheque" || depense.mode_paiement == "Chèque" || depense.mode_paiement == "cheque" || depense.mode_paiement == "chèque"{
                res.append(depense)
            }
        }
        res.sorted(by: { $0.date_paiement! < $1.date_paiement!})
        return res
    }
}
