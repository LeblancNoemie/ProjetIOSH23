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
        var res : Projet = Projet()
        for project in ProjectDataManager.shared.getAllProjects(){
            if project.nom == name {
                res = project
            }
        }
        return res
    }
    
    func getProjetById(id: Int16) -> Projet {
        var res : Projet = Projet()
        for project in ProjectDataManager.shared.getAllProjects(){
            if project.id == id {
                res = project
            }
        }
        return res
        
    }
    
    func addProject(id: Int16, name: String) {
        ProjectDataManager.shared.saveProject(id:id, name:name)
    }
    
    func removeProject(id: Int16) {
        ProjectDataManager.shared.deleteProject(id: id)
    }
    
    
}
