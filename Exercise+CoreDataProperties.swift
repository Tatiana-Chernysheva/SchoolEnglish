//
//  Exercise+CoreDataProperties.swift
//  SchoolEnglish
//
//  Created by Lev Ivanov on 09.07.2021.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var answer: String?
    @NSManaged public var clazz: Int16
    @NSManaged public var id: Int16
    @NSManaged public var ord: Int16
    @NSManaged public var question: String?
    @NSManaged public var title: String?
    @NSManaged public var transcription: String?

}

extension Exercise : Identifiable {

}
