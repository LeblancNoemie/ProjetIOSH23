//
//  Depense+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-08.
//
//

import Foundation
import CoreData


extension Depense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Depense> {
        return NSFetchRequest<Depense>(entityName: "Depense")
    }

    @NSManaged public var mode_paiement: String?
    @NSManaged public var date_paiement: Date?
    @NSManaged public var type_depense: String?
    @NSManaged public var prix: NSDecimalNumber?
    @NSManaged public var nom_projet: String?
    @NSManaged public var compte_id: Int16

}

extension Depense : Identifiable {

}
