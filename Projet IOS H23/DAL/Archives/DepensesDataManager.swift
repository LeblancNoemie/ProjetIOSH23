//
//  ComptesDataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-14.
//

import Foundation
import CoreData
import UIKit

class DepensesDataManager{
    
    //This class is deprecated -> Now using web api for data
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
    
    //Deprecated -> See DataManager.initAppData()
    func initDepenses() {
//        let context = persistentContainer.viewContext
//        //Ajout de projets sur l'application
//        let d1 = Depense(context: context)
//        let d2 = Depense(context: context)
//
//        let p1 = Projet(context: context)
//            p1.nom = "YUL Condominium"
//            p1.id = 100
//        let c1 = Compte(context: context)
//            c1.montant = 250000.99
//            c1.nom_banque = "Banque Royale du Canada"
//            c1.compte_id = 201
//
//        //Relationships dépense 1 Projet 1
//        d1.projet = p1
//        d1.compte = c1
//        //Attribute dépense 1 Projet 1
//        d1.date_paiement = generateDate(year:2023, month:8,day:18)
//        d1.depense_id = 301
//        d1.mode_paiement = "Chèque"
//        d1.prix = 8000
//        d1.type_depense = "Sol béton"
//
//        //Relationships dépense 2 Projet 1
//        d2.projet = p1
//        d2.compte = c1
//        //Attribute dépense 2 Projet 1
//        d2.date_paiement = generateDate(year:2022, month:3,day:7)
//        d2.depense_id = 302
//        d2.mode_paiement = "Espèce"
//        d2.prix = 15000
//        d2.type_depense = "Fenêtres"
//
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
    func saveDepense(prj : Projet, cpt:Compte, datePaiement: Date, dps_id: Int16, mode:String, prx: Double, type:String) -> Bool {
        let context = persistentContainer.viewContext
        let newDepense = NSEntityDescription.insertNewObject(forEntityName: "Depense", into: context)
        newDepense.setValue(prj, forKey: "projet")
        newDepense.setValue(cpt, forKey: "compte")
        newDepense.setValue(datePaiement, forKey: "date_paiement")
        newDepense.setValue(dps_id, forKey: "depense_id")
        newDepense.setValue(mode, forKey: "mode_paiement")
        newDepense.setValue(prx, forKey: "prix")
        newDepense.setValue(type, forKey: "type_depense")
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
    func getAll() -> [Depense] {
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        let context = persistentContainer.viewContext
        do{
            return try context.fetch(request)
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getAllByNomBanque(bank_name: String) -> [Depense]{
        var res : [Depense] = []
        for depense in getAll(){
            if depense.compte?.nom_banque == bank_name {
                res.append(depense)
            }
        }
        return res
    }
    
    func getAllByProjectName(projectName:String) -> [Depense] {
        var res : [Depense] = []
        for depense in getAll(){
            if depense.projet?.nom == projectName {
                res.append(depense)
            }
        }
        return res
    }
    
    func getAllByModePaiement(payment_mode: String) -> [Depense]{
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        let filter = NSPredicate(format: "mode_paiement == %@", payment_mode)
        request.predicate = filter
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
    func deleteDepense(id: Int16){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        let filter = NSPredicate(format: "depense_id == %@", id)
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
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        do {
            let depenses = try context.fetch(request)
            if depenses.count > 0 {
                for depense in depenses {
                    context.delete(depense)
                }
            }
        } catch {
            print("Error \(error)")
        }
    }
}
