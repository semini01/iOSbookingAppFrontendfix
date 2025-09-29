//
//  BookingEntity+CoreData.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-18.
//

import Foundation
import CoreData

@objc(BookingEntity)
public class BookingEntity: NSManagedObject {}

extension BookingEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookingEntity> {
        NSFetchRequest<BookingEntity>(entityName: "BookingEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var hotelName: String?
    @NSManaged public var checkInDate: Date?
    @NSManaged public var checkOutDate: Date?
}
