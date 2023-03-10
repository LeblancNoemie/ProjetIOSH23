//
//  Compte+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//
//

import Foundation
import CoreData


extension Compte {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Compte> {
        return NSFetchRequest<Compte>(entityName: "Compte")
    }

    @NSManaged public var compte_id: Int16
    @NSManaged public var montant: NSDecimalNumber?
    @NSManaged public var nom_banque: String?
    @NSManaged public var conventions: NSSet?
    @NSManaged public var depenses: NSSet?
    @NSManaged public var projet: NSSet?

}

// MARK: Generated accessors for conventions
extension Compte {

    @objc(addConventionsObject:)
    @NSManaged public func addToConventions(_ value: Convention)

    @objc(removeConventionsObject:)
    @NSManaged public func removeFromConventions(_ value: Convention)

    @objc(addConventions:)
    @NSManaged public func addToConventions(_ values: NSSet)

    @objc(removeConventions:)
    @NSManaged public func removeFromConventions(_ values: NSSet)

}

// MARK: Generated accessors for depenses
extension Compte {

    @objc(addDepensesObject:)
    @NSManaged public func addToDepenses(_ value: Depense)

    @objc(removeDepensesObject:)
    @NSManaged public func removeFromDepenses(_ value: Depense)

    @objc(addDepenses:)
    @NSManaged public func addToDepenses(_ values: NSSet)

    @objc(removeDepenses:)
    @NSManaged public func removeFromDepenses(_ values: NSSet)

}

// MARK: Generated accessors for projet
extension Compte {

    @objc(addProjetObject:)
    @NSManaged public func addToProjet(_ value: Entreprise)

    @objc(removeProjetObject:)
    @NSManaged public func removeFromProjet(_ value: Entreprise)

    @objc(addProjet:)
    @NSManaged public func addToProjet(_ values: NSSet)

    @objc(removeProjet:)
    @NSManaged public func removeFromProjet(_ values: NSSet)

}

extension Compte : Identifiable {

}
