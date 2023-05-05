//
//  DataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import Foundation
import CoreData

class DataManager{
    
    //This class is deprecated -> Now using web api for data

    static let shared = DataManager()
    
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
    
    func initAppData(){
        let context = persistentContainer.viewContext
        
        //Ajout de projets sur l'application
        let p1 = Projet(context: context)
        let p2 = Projet(context:context)
        let c1 = Compte(context: context)
        let c2 = Compte(context: context)
        let d1 = Depense(context: context)
        let d2 = Depense(context: context)
        let cv1 = Convention(context: context)
        let cv2 = Convention(context: context)
        
        p1.nom = "YUL Condominium"
        p1.id = 100
        
        p2.nom = "Les Jardins Mercier"
        p2.id = 101
        
        c1.montant = 250000.99
        c1.nom_banque = "Banque Royale du Canada"
        c1.compte_id = 201
        
        c2.montant = 934000.99
        c2.nom_banque = "Banque Nationale"
        c2.compte_id = 202

        c1.montant = 250000.99
        c1.nom_banque = "Banque Royale du Canada"
        c1.compte_id = 201
        
        d1.projet = p1
        d1.compte = c1
        d1.date_paiement = generateDate(year:2023, month:8,day:18)
        d1.depense_id = 301
        d1.mode_paiement = "Chèque"
        d1.prix = 8000
        d1.type_depense = "Sol béton"
        
        d2.projet = p1
        d2.compte = c1
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
    
    func deleteAllDataApp(){
        ConventionsDataManager.shared.deleteAll()
        DepensesDataManager.shared.deleteAll()
        ComptesDataManager.shared.deleteAll()
        ProjectDataManager.shared.deleteAll()
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

