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
        let d2 = Depense(context: context)
        
        let p1 = Projet(context: context)
            p1.nom = "YUL Condominium"
            p1.id = 100
        let c1 = Compte(context: context)
            c1.montant = 250000.99
            c1.nom_banque = "Banque Royale du Canada"
            c1.compte_id = 201
        
        //Relationships dépense 1 Projet 1
        d1.projet = p1
        d1.compte = c1
        //Attribute dépense 1 Projet 1
        d1.date_paiement = generateDate(year:2023, month:8,day:18)
        d1.depense_id = 301
        d1.mode_paiement = "Chèque"
        d1.prix = 8000
        d1.type_depense = "Sol béton"
        
        //Relationships dépense 2 Projet 1
        d2.projet = p1
        d2.compte = c1
        //Attribute dépense 2 Projet 1
        d2.date_paiement = generateDate(year:2022, month:3,day:7)
        d2.depense_id = 302
        d2.mode_paiement = "Espèce"
        d2.prix = 15000
        d2.type_depense = "Fenêtres"
       
         do{
             try context.save()
         }catch{
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
         }
     }
    
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
    
    func getDepenseByBank(bank_name: String) -> Depense{
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        let filter = NSPredicate(format: "nom_banque == %@", bank_name)
        request.predicate = filter
        do{
            return try context.fetch(request).first!
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    func saveDepense(prj : Projet, cpt:Compte, datePaiement: Date, dps_id: Int16, mode:String, prx: Double, type:String){
        let context = persistentContainer.viewContext
        let newDepense = NSEntityDescription.insertNewObject(forEntityName: "Depenses", into: context)
        newDepense.setValue(prj, forKey: "projet")
        newDepense.setValue(cpt, forKey: "compte")
        newDepense.setValue(datePaiement, forKey: "date_paiement")
        newDepense.setValue(dps_id, forKey: "depense_id")
        newDepense.setValue(mode, forKey: "mode_paiement")
        newDepense.setValue(prx, forKey: "prix")
        newDepense.setValue(type, forKey: "type_depense")
        do{
            try context.save()
        }catch{
            print("Error: \(error)")
        }
    }
    
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
