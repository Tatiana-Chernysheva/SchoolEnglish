//
//  Exercise+CoreDataProperties.swift
//  Portal
//
//  Created by Lev Ivanov on 24.06.2021.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var english: String?
    @NSManaged public var id: Int16
    @NSManaged public var transcription: String?
    @NSManaged public var translation: String?

}

extension Exercise : Identifiable {

}
