//
//  CachedUser+CoreDataProperties.swift
//  Milestone4
//
//  Created by admin on 26.08.2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var cachedFriend: NSSet?

    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedAge: Int {
        Int(age) ?? 1
    }
    public var wrappedAbout: String {
        about ?? "Unknown description"
    }
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    public var wrappedRegistered: String {
        
        registered?.formatted(date: .numeric, time: .omitted) ?? "Unknown company"
    }
    
    public var friendsArray: [CachedFriend] {
        let set = cachedFriend as? Set<CachedFriend> ?? []
        
        return set.sorted { $0.wrappedName < $1.wrappedName}
    }
    //func addFriend
}

// MARK: Generated accessors for cachedFriend
extension CachedUser {

    @objc(addCachedFriendObject:)
    @NSManaged public func addToCachedFriend(_ value: CachedFriend)

    @objc(removeCachedFriendObject:)
    @NSManaged public func removeFromCachedFriend(_ value: CachedFriend)

    @objc(addCachedFriend:)
    @NSManaged public func addToCachedFriend(_ values: NSSet)

    @objc(removeCachedFriend:)
    @NSManaged public func removeFromCachedFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
