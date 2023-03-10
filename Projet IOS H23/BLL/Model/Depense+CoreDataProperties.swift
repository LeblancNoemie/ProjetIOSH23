//
//  Depense+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//
//

import Foundation
import CoreData


extension Depense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Depense> {
        return NSFetchRequest<Depense>(entityName: "Depense")
    }

    @NSManaged public var date_paiement: Date?
    @NSManaged public var mode_paiement: String?
    @NSManaged public var prix: NSDecimalNumber?
    @NSManaged public var type_depense: String?
    @NSManaged public var compte: Compte?
    @NSManaged public var projet: Entreprise?

}

extension Depense : Identifiable {

}
