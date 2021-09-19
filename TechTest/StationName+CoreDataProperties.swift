//
//  StationName+CoreDataProperties.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//
//

import Foundation
import CoreData


extension StationName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StationName> {
        return NSFetchRequest<StationName>(entityName: "StationName")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var stationCode: String?
    @NSManaged public var stationDesc: String?
    @NSManaged public var stationId: Int16
    @NSManaged public var stationLatitude: Double
    @NSManaged public var stationLongitude: Double

}
