//
//  Compte+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-08.
//
//

import Foundation
import CoreData


extension Compte {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Compte> {
        return NSFetchRequest<Compte>(entityName: "Compte")
    }

    @NSManaged public var compte_id: Int16
    @NSManaged public var banque: String?
    @NSManaged public var montant: NSDecimalNumber?

}

extension Compte : Identifiable {

}
