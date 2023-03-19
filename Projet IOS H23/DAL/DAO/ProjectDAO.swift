//
//  ProjectDAO.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-14.
//

import Foundation
import CoreData

protocol IProjectDAO{
    func getAllProjects()->[Projet]
    func getProjectByName(name:String)->Projet
    func getProjetById(id:Int16)->Projet
    func addProject(id:Int16, name:String)
    func removeProject(id:Int16)
}

class ProjectDAO : IProjectDAO{
    
    //Singleton
    static let shared = ProjectDAO()
    
    func getAllProjects() -> [Projet] {
        return ProjectDataManager.shared.getAllProjects()
    }
    
    func getProjectByName(name: String) -> Projet {
        return ProjectDataManager.shared.getProjectByName(name: name)
    }
    
    func getProjetById(id: Int16) -> Projet {
        return ProjectDataManager.shared.getProjectById(id: id)
    }
    
    func addProject(id: Int16, name: String) {
        ProjectDataManager.shared.saveProject(id:id, name:name)
    }
    
    func removeProject(id: Int16) {
        ProjectDataManager.shared.deleteProject(id: id)
    }
    
    func getTotalSpending(projectName: String) -> Double {
        //Pas fonctionnel?
        var total : Double = 50.00
        for element in ProjectDataManager.shared.getDepensesFromProject(name: projectName){
            total = total + Double(element.prix!)
        }
        return total
    }
}
