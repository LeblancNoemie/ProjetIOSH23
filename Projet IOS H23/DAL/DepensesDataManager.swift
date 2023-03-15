//
//  ComptesDataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-14.
//

import Foundation
import CoreData

class DepensesDataManager{
    
    static let shared = DepensesDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Projet IOS H23")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //
    //   Depense entity
    //
    
//    func initDepenses() {
//        let context = persistentContainer.viewContext
//        //Ajout de projets sur l'application
//
//        //Projet 1:
//
//        //Projet 2:
//
//
//         do{
//             try context.save()
//         }catch{
//             let nserror = error as NSError
//             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//         }
//     }
    
    func getAllDepenses() -> [Depense] {
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        let context = persistentContainer.viewContext
        do{
            return try context.fetch(request)
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
//    func saveCompte(){
//        let context = persistentContainer.viewContext
//
//        do{
//            try context.save()
//        }catch{
//            print("Error: \(error)")
//        }
//    }
    
    func deleteDepense(id: Int16){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
        let filter = NSPredicate(format: "compte_id == %@", id)
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
    
    //TODO À retravailler...
//    func updateProject(oldPrjectId : Int16, newId: Int16, newMontant: Double, newBank: String){
//        let context = persistentContainer.viewContext
//
//        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
//        let filter = NSPredicate(format: "id == %@", oldPrjectId)
//        request.predicate = filter
//        do{
//            let prj = try context.fetch(request).first!
//            if prj != nil {
//                prj.setValue(newProject.id, forKey: "id")
//                prj.setValue(newProject.nom, forKey: "nom")
//            }
//        }catch{
//
//        }
//    }
}
