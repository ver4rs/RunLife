//
//  Workout+CoreDataProperties.swift
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

extension Workout {

    @NSManaged var workout_date: NSDate?
    @NSManaged var workout_distance: NSNumber?
    @NSManaged var workout_duration: NSNumber?
    @NSManaged var workout_identifier: String?
    @NSManaged var location: Location?

}
