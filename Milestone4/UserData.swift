//
//  UserData.swift
//  Milestone4
//
//  Created by admin on 26.08.2022.
//

import Foundation
import SwiftUI
import CoreData

class Users: ObservableObject {
    @Environment(\.managedObjectContext) var moc
    @Published var users = [User]()
    @Published var coreDataUsers: [CachedUser] = []
    
    
    
    func loadCoreData() {
        for user in users {
            let newUser = CachedUser(context: moc)
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
                let newFriend: CachedFriend  = CachedFriend(context: moc)
                newFriend.id = friend.id
                newFriend.name = friend.name
                newUser.addToCachedFriend(newFriend)
            }
            

            do {
                try moc.save()
                print("Loaded correctly")
            } catch let error {
                print("error saving data. \(error.localizedDescription)")
            }
        }
        
    }
    
    func fetchData(decodedContext: @escaping ([User]) -> ()) {
        let urlAddress = "https://www.hackingwithswift.com/samples/friendface.json"
        
        guard let url = URL(string: urlAddress) else {
            print("Invalid URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print("Invalid Data. error occured: \(error?.localizedDescription ?? "Error")")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decoded = try decoder.decode([User].self, from: data)
                    decodedContext(decoded)
                
                print("decoded correctly")
            } catch {
                print("Unable to decode: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func findUser(id: String) -> User {
        guard let user = self.users.first(where: { (oneUser) -> Bool in
            oneUser.id == id
        }) else {
            return self.users.first!
        }
        return user
    }
    
}


struct Friend: Identifiable, Codable {
    let id: String
    let name: String
}

struct User: Identifiable, Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let friends: [Friend]
    
}
