//
//  Note+CoreDataProperties.swift
//  homeWork26 (shio andghuladze)
//
//  Created by shio andghuladze on 25.08.22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var details: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
