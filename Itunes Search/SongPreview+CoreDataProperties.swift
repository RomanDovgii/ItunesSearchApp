//
//  SongPreview+CoreDataProperties.swift
//  Itunes Search
//
//  Created by Roman Dovgii on 1/6/23.
//
//

import Foundation
import CoreData


extension SongPreview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongPreview> {
        return NSFetchRequest<SongPreview>(entityName: "SongPreview")
    }

    @NSManaged public var artwork: Data?

}

extension SongPreview : Identifiable {

}
