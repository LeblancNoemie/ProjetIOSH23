//
//  ApiProtocols.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-05-03.
//

import Foundation
protocol WhenProjectsReady{
    func loadData(data:[aProjet])
}

protocol WhenComptesReady{
    func loadData(data:[aCompte])
}

protocol WhenDepensesReady{
    func loadData(data:[aDepense])
}

protocol WhenConventionsReady{
    func loadData(data:[aConvention])
}
