//
//  Entreprise+CoreDataProperties.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//
//

import Foundation
import CoreData


extension Entreprise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entreprise> {
        return NSFetchRequest<Entreprise>(entityName: "Projet")
    }

    @NSManaged public var id: Int16
    @NSManaged public var compte: NSSet?
    @NSManaged public var conventions: NSSet?
    @NSManaged public var depenses: NSSet?

}

// MARK: Generated accessors for compte
extension Entreprise {

    @objc(addCompteObject:)
    @NSManaged public func addToCompte(_ value: Compte)

    @objc(removeCompteObject:)
    @NSManaged public func removeFromCompte(_ value: Compte)

    @objc(addCompte:)
    @NSManaged public func addToCompte(_ values: NSSet)

    @objc(removeCompte:)
    @NSManaged public func removeFromCompte(_ values: NSSet)

}

// MARK: Generated accessors for conventions
extension Entreprise {

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
extension Entreprise {

    @objc(addDepensesObject:)
    @NSManaged public func addToDepenses(_ value: Depense)

    @objc(removeDepensesObject:)
    @NSManaged public func removeFromDepenses(_ value: Depense)

    @objc(addDepenses:)
    @NSManaged public func addToDepenses(_ values: NSSet)

    @objc(removeDepenses:)
    @NSManaged public func removeFromDepenses(_ values: NSSet)

}

extension Entreprise : Identifiable {

}
