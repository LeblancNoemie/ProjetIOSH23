//
//  Convention+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-08.
//
//

import Foundation
import CoreData


extension Convention {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Convention> {
        return NSFetchRequest<Convention>(entityName: "Convention")
    }

    @NSManaged public var fournisseur: String?
    @NSManaged public var type_convention: String?
    @NSManaged public var prix: NSDecimalNumber?
    @NSManaged public var date_fin: Date?
    @NSManaged public var nom_projet: String?
    @NSManaged public var compte_id: String?

}

extension Convention : Identifiable {

}
