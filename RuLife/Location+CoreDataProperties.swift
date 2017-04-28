//
//  Location+CoreDataProperties.swift
//  RuLife
//
//  Created by Martin Sekerák on 28.03.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var location_latitude: NSNumber?
    @NSManaged var location_longitude: NSNumber?
    @NSManaged var location_time: NSDate?
    @NSManaged var location_identifier: String?
    @NSManaged var workout: Workout?

}
