//
//  ConventionsDataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-14.
//

import Foundation
import CoreData

class ConventionsDataManager{
    
    static let shared = ConventionsDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Projet IOS H23")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Deprecated -> See DataManager.initAppData()
    func initConventions() {
     }
    
    /*
     * 'Create' function
     */
    func saveConvention(projet : Projet, compte:Compte, conv_id : Int16, dateFin : Date, fournisseur: String, prix: Double, conv_type : String) -> Bool{
        let context = persistentContainer.viewContext
        let convention = NSEntityDescription.insertNewObject(forEntityName: "Convention", into: context)
        convention.setValue(projet, forKey: "projet")
        convention.setValue(compte, forKey: "compte")
        convention.setValue(conv_id, forKey: "convention_id")
        convention.setValue(dateFin, forKey: "date_fin")
        convention.setValue(fournisseur, forKey: "fournisseur")
        convention.setValue(prix, forKey: "prix")
        convention.setValue(conv_type, forKey: "type_convention")
        do{
            try context.save()
            return true
        }catch{
            print("Error: \(error)")
            return false
        }
    }
    
    /*
     * 'Read' function
     */
    func getAllConventions() -> [Convention] {
        let request : NSFetchRequest<Convention> = Convention.fetchRequest()
        let context = persistentContainer.viewContext
        do{
            return try context.fetch(request)
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    /*
     * 'Delete' function
     */
    func deleteConvention(id: Int16){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Convention> = Convention.fetchRequest()
        let filter = NSPredicate(format: "convention_id == %@", id)
        request.predicate = filter
        do{
            let dps = try context.fetch(request).first
            if dps != nil {
                context.delete(dps!)
            }
        }catch{
            print("Error: \(error)")
        }
    }
            
    func deleteAll(){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Convention> = Convention.fetchRequest()
        do {
            let conventions = try context.fetch(request)
//            print("There are currently: \(depenses.count)")
            if conventions.count > 0 {
                for convention in conventions {
                    context.delete(convention)
                }
            }
//            print("Items now deleted. There are \(DepensesDataManager.shared.getAllDepenses().count) items now.")
        } catch {
            print("Error \(error)")
        }
    }
}
