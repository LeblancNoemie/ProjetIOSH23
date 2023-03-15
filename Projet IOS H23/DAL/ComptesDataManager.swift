//
//  ComptesDataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-14.
//

import Foundation
import CoreData

class ComptesDataManager{
    
//    static let shared = ComptesDataManager()
//
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "Projet IOS H23")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    //
//    //   Compte entity
//    //
//
//    func initComptes() {
//        let context = persistentContainer.viewContext
//        //Ajout de projets sur l'application
//
//        //Projet 1:
//        let p1 = Projet(context: context)
//            p1.nom = "YUL Condominium"
//            p1.id = 100
//
//        let c1 = Compte(context: context)
//        c1.compte_id = 201
//        c1.montant = 100000.99
//        c1.nom_banque = "Banque nationale"
//        c1.addToProjet(p1)
//        let c2 = Compte(context: context)
//        c2.compte_id = 202
//        c2.montant = 250000.33
//        c2.nom_banque = "Banque Royale du Canada"
//        c2.addToProjet(p1)
//
//        //Projet 2:
//        let p2 = Projet(context: context)
//            p2.nom = "Les Jardins Mercier"
//            p2.id = 101
//
//        let c3 = Compte(context: context)
//        c3.compte_id = 203
//        c3.montant = 123000.99
//        c3.nom_banque = "Banque nationale"
//        c3.addToProjet(p1)
//        let c4 = Compte(context: context)
//        c4.compte_id = 204
//        c4.montant = 96499.33
//        c4.nom_banque = "Banque Royale du Canada"
//        c4.addToProjet(p1)
//
//         do{
//             try context.save()
//         }catch{
//             let nserror = error as NSError
//             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//         }
//     }
//
//    func getAllComptes() -> [Compte] {
//        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
//        let context = persistentContainer.viewContext
//        do{
//            return try context.fetch(request)
//        }catch{
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//    }
//
//    func saveCompte(compteId: Int16, montant: Double, nomBanque: String){
//        let context = persistentContainer.viewContext
//        let newCompte = NSEntityDescription.insertNewObject(forEntityName: "Compte", into: context)
//        newCompte.setValue(compteId, forKey: "compte_id")
//        newCompte.setValue(montant, forKey: "montant")
//        newCompte.setValue(nomBanque, forKey: "nom_banque")
//        do{
//            try context.save()
//        }catch{
//            print("Error: \(error)")
//        }
//    }
//
//    func deleteCompte(id: Int16){
//        let context = persistentContainer.viewContext
//        let request : NSFetchRequest<Compte> = Compte.fetchRequest()
//        let filter = NSPredicate(format: "compte_id == %@", id)
//        request.predicate = filter
//        do{
//            let prj = try context.fetch(request).first
//            if prj != nil {
//                context.delete(prj!)
//            }
//        }catch{
//            print("Error: \(error)")
//        }
//    }
//
//    //TODO À retravailler...
////    func updateProject(oldPrjectId : Int16, newId: Int16, newMontant: Double, newBank: String){
////        let context = persistentContainer.viewContext
////
////        let request : NSFetchRequest<Projet> = Projet.fetchRequest()
////        let filter = NSPredicate(format: "id == %@", oldPrjectId)
////        request.predicate = filter
////        do{
////            let prj = try context.fetch(request).first!
////            if prj != nil {
////                prj.setValue(newProject.id, forKey: "id")
////                prj.setValue(newProject.nom, forKey: "nom")
////            }
////        }catch{
////
////        }
////    }
}
