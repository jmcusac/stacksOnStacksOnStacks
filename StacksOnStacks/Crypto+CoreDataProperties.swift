//
//  Crypto+CoreDataProperties.swift
//  StacksOnStacks
//
//  Created by Jason Cusack on 03/30/2021.
//  Copyright © 2021 CuSoft. All rights reserved.
//

import Foundation
import CoreData


extension Crypto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crypto> {
        return NSFetchRequest<Crypto>(entityName: "Crypto")
    }

    @NSManaged public var name: String
    @NSManaged public var desription: String
    @NSManaged public var rating: String

}
