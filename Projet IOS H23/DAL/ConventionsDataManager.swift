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
    
    func initConventions() {
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
    
    /*
     * 'Create' function
     */
    func saveConvention(projet : Projet, compte:Compte, conv_id : Int16, dateFin : Data, fournisseur: String, prix: Double, conv_type : String){
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
        }catch{
            print("Error: \(error)")
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
