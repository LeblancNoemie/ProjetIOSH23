//
//  Convention+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//
//

import Foundation
import CoreData


extension Convention {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Convention> {
        return NSFetchRequest<Convention>(entityName: "Convention")
    }

    @NSManaged public var date_fin: Date?
    @NSManaged public var fournisseur: String?
    @NSManaged public var prix: NSDecimalNumber?
    @NSManaged public var type_convention: String?
    @NSManaged public var compte: Compte?
    @NSManaged public var projet: Entreprise?

}

extension Convention : Identifiable {

}
