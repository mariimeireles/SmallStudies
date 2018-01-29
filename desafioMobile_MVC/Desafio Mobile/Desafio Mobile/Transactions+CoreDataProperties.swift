//
//  Transactions+CoreDataProperties.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 02/11/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//
//
import Foundation
import CoreData

extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: String?
    @NSManaged public var cardNumber: String?
    @NSManaged public var date: String?

}
