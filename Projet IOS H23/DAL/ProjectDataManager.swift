//
//  DataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import Foundation
import CoreData

class ProjectDataManager {
    //définir un singleton
    static let shared = ProjectDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Projet_IOS_H23")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //
    //  Projet entity
    //
    
    //Deprecated -> See DataManager.initAppData()
    func initProjets() {        
//        let context = persistentContainer.viewContext
//        //Ajout de projets sur l'application
//        let p1 = Projet(context: context)
//        p1.nom = "YUL Condominium"
//        p1.id = 100
//        let p2 = Projet(context:context)
//        p2.nom = "Les Jardins Mercier"
//        p2.id = 101
//         do{
//             try context.save()
//         }catch{
//             let nserror = error as NSError
//             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//         }
     }
    
    /*
     * 'Create' function
     */
    func saveProject(id:Int16, name:String){
        let context = persistentContainer.viewContext
        let newProject = NSEntityDescription.insertNewObject(forEntityName: "Projet", into: context)
        newProject.setValue(id, forKey: "id")
        newProject.setValue(name, forKey: "nom")
        do{
            try context.save()
        }catch{
            print("Error: \(error)")
        }
    }
    
    /*
     * 'Read' functions
     */
    func getAllProjects() -> [Projet] {
        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
        let context = persistentContainer.viewContext
        do{
            return try context.fetch(request)
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getProjectById(id: Int16) -> Projet{
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
        let filter = NSPredicate(format: "id == %@", id)
        request.predicate = filter
        do{
            return try context.fetch(request).first!
        }catch{
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return Projet()
    }
    
    func getProjectByName(name: String) -> Projet{
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
        let filter = NSPredicate(format: "nom == %@", name)
        request.predicate = filter
        do{
            return try context.fetch(request).first ?? Projet()
        }catch{
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return Projet()
    }
    
    func getDepensesFromProject(name: String) -> [Depense]{
//        let res : [Depense] = Array(getProjectByName(name: name).depenses as! Set<Depense>)
        let projet = getProjectByName(name: name)
        return projet.depenses?.allObjects as! [Depense]
    }
    
    /*
     * 'Update' function
     */
    func updateProject(oldPrjectId : Int16, newId: Int16, newName: String){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
        let filter = NSPredicate(format: "id == %@", oldPrjectId)
        request.predicate = filter
        do{
            let prj = try context.fetch(request).first!
            prj.setValue(newId, forKey: "id")
            prj.setValue(newName, forKey: "nom")
            try context.save()
            
        }catch{
            print("Error: \(error)")
        }
    }
    
    /*
     * 'Delete' functions
     */
    func deleteProject(id: Int16){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
        let filter = NSPredicate(format: "id == %@", id)
        request.predicate = filter
        do{
            let prj = try context.fetch(request).first
            if prj != nil {
                context.delete(prj!)
            }
        }catch{
            print("Error: \(error)")
        }
    }
    
    func deleteAll(){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
        do {
            let projects = try context.fetch(request)
            if projects.count > 0 {
                for project in projects as [Projet]{
                    context.delete(project)
                    context
                }
            }
        } catch {
            print("Error \(error)")
        }
    }
}
