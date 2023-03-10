//
//  DataManager.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import Foundation
import CoreData

class DataManager {
    //définir un singleton
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "sol_td05")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func initProjet() {
        let context = persistentContainer.viewContext
        let p1 = Projet(context: context)
        p1.nom = "YUL Condominium"
        p1.id = 100
         
        let p2 = Projet(context:context)
        p2.nom = "Les Jardins Mercier"
        p2.id = 101
                 
         do{
             try context.save()
         }catch{
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
         }
     }
}
