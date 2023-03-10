//
//  Entreprise+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-08.
//
//

import Foundation
import CoreData


extension Entreprise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entreprise> {
        return NSFetchRequest<Entreprise>(entityName: "Entreprise")
    }

    @NSManaged public var total_depenses: NSDecimalNumber?
    @NSManaged public var id_compte_rbc: Int16
    @NSManaged public var id_compte_bn: Int16
    @NSManaged public var id: Int16

}

extension Entreprise : Identifiable {

}
