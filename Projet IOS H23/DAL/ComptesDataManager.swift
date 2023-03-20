//
//  ComptesDataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-14.
//

import Foundation
import CoreData

class ComptesDataManager{

   static let shared = ComptesDataManager()
    
    
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
    //  Compte entity
    //
    
    //Deprecated -> See DataManager.initAppData()
    func initComptes() {
//        let context = persistentContainer.viewContext
//        //Ajout de projets sur l'application
//        let c1 = Compte(context: context)
//        c1.montant = 250000.99
//        c1.nom_banque = "Banque Royale du Canada"
//        c1.compte_id = 201
//
//        let c2 = Compte(context: context)
//        c2.montant = 934000.99
//        c2.nom_banque = "Banque Nationale"
//        c2.compte_id = 202
//         do{
//             try context.save()
//         }catch{
//             let nserror = error as NSError
//             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//         }
     }
    
    /*
     * 'Read' function
     */
    func getAllComptes() -> [Compte] {
        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
        let context = persistentContainer.viewContext
        do{
            return try context.fetch(request)
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getCompteById(id: Int16) -> Compte{
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
        let filter = NSPredicate(format: "compte_id == %@", id)
        request.predicate = filter
        do{
            return try context.fetch(request).first!
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getCompteByName(name: String) -> Compte{
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
        let filter = NSPredicate(format: "nom_banque == %@", name)
        request.predicate = filter
        do{
            return try context.fetch(request).first ?? Compte()
        }catch{
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return Compte()
    }
    
    /*
     * 'Update' function
     */
    func updateCompte(oldCompteId : Int16, newId: Int16, newBank: String, newAmount: Double){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
        let filter = NSPredicate(format: "compte_id == %@", oldCompteId)
        request.predicate = filter
        do{
            let prj = try context.fetch(request).first!
            prj.setValue(newId, forKey: "compte_id")
            prj.setValue(newBank, forKey: "nom_banque")
            prj.setValue(newAmount, forKey: "montant")
            try context.save()
            
        }catch{
            print("Error: \(error)")
        }
    }
    
    /*
     * 'Delete' function
     */
    func deleteAll(){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
        do {
            let comptes = try context.fetch(request)
            if comptes.count > 0 {
                for compte in comptes as [Compte]{
                    context.delete(compte)
                }
            }
        } catch {
            print("Error \(error)")
        }
    }
}
