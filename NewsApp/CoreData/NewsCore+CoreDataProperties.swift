//
//  NewsCore+CoreDataProperties.swift
//  NewsApp
//
//  Created by Vũ Linh on 07/07/2021.
//
//

import Foundation
import CoreData

extension NewsCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsCore> {
        return NSFetchRequest<NewsCore>(entityName: "NewsCore")
    }

    // NSManaged = the variable will be resolve at runtime
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var url: String?
    @NSManaged public var author: String?
    @NSManaged public var published: String?

}

extension NewsCore: Identifiable {

}
