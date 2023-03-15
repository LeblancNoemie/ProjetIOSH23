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
        
        let container = NSPersistentContainer(name: "Projet_IOS_H23")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func initDepenses() {
        let context = persistentContainer.viewContext
        //Ajout de projets sur l'application
        let d1 = Depense(context: context)
        
        //Relationships
        let p1 = Projet(context: context)
            p1.nom = "YUL Condominium"
            p1.id = 100
        let c1 = Compte(context: context)
            c1.montant = 250000.99
            c1.nom_banque = "Banque Royale du Canada"
            c1.compte_id = 201
        
        d1.projet = p1
        d1.compte = c1
        //Attribute
        d1.date_paiement = generateDate(year:2023, month:8,day:18)
        d1.depense_id = 301
        d1.mode_paiement = "Chèque"
        d1.prix = 8000
        d1.type_depense = "Sol béton"
       
         do{
             try context.save()
         }catch{
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
         }
     }
    
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
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getProjectByName(name: String) -> Projet{
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
        let filter = NSPredicate(format: "nom == %@", name)
        request.predicate = filter
        do{
            return try context.fetch(request).first!
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
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
        
    func generateDate(year: Int, month: Int, day:Int) -> Date {
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
            dateComponents.hour = Int.random(in: 1..<23)
            dateComponents.minute = Int.random(in: 1..<60)

            // Create date from components
            let userCalendar = Calendar(identifier: .gregorian) // since the components above (like year 1980) are for Gregorian
            return userCalendar.date(from: dateComponents)!
        }
    
}
