//
//  DataController.swift
//  Milestone4
//
//  Created by admin on 26.08.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let jsonUsers = Users()
    let container = NSPersistentContainer(name: "CoreDataModel")
    @Published var savedEntities: [CachedUser] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error occured: \(error.localizedDescription)")
                
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        fetchCoreData()
    }
    func fetchCoreData() {
        let request = NSFetchRequest<CachedUser>(entityName: "CachedUser")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Catched arror: \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        
        do {
            try container.viewContext.save()
            fetchCoreData()
            print("Loaded correctly")
        } catch let error {
            print("error saving data. \(error.localizedDescription)")
        }
    }
    
    func addToCoreData() async {
        DispatchQueue.global().async {
            DataController.jsonUsers.fetchData { [self] users in
                DispatchQueue.main.async {
                    for user in users {
                        let newUser = CachedUser(context: self.container.viewContext)
                        newUser.name = user.name
                        newUser.id = user.id
                        newUser.about = user.about
                        newUser.address = user.address
                        newUser.email = user.email
                        newUser.company = user.company
                        newUser.isActive = user.isActive
                        newUser.age = Int16(user.age)
                        newUser.registered = user.registered
                        for friend in user.friends {
                            let newFriend: CachedFriend  = CachedFriend(context: self.container.viewContext)
                            newFriend.id = friend.id
                            newFriend.name = friend.name
                            newUser.addToCachedFriend(newFriend)
                        }
                    }
                    self.saveData()
                }
                
            }
        }
        
    }
    func findCachedUser(id: String) -> CachedUser {
        guard let user = savedEntities.first(where: { (oneUser) -> Bool in
            oneUser.id == id
        }) else {
            return self.savedEntities.first!
        }
        return user
    }
}
