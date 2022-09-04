//
//  DetailView.swift
//  Milestone4
//
//  Created by admin on 26.08.2022.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var vm: DataController
    var user: CachedUser
    
    
    var body: some View {
        ScrollView(.vertical) {
        ZStack {
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .padding()
                    .foregroundColor(.secondary)
                    .overlay {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundColor(user.isActive ? .green : .red)
                            .offset(x: -70, y: 70)
                            .opacity(0.6)
                    }
                Text("Name: \(user.wrappedName)")
                    .font(.headline)
                    .fontWeight(.regular)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(15)
                Spacer()
                HStack {
                    VStack(spacing: 25) {
                        Text("\(ageEmoji()) : \(user.age) y.o.")
                        Text("💼: \(user.wrappedCompany)")
                        Text("🕐: \(user.wrappedRegistered)")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
                .padding(10)
                .font(.system(size: 18))
                
                VStack(alignment: .leading) {
                    Text("Friends")
                        .padding(.leading)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(user.friendsArray) { friend in
                            NavigationLink {
                                DetailView(vm: vm, user: vm.findCachedUser(id: friend.id ?? ""))
                            } label: {
                                HStack {
                                    Image(systemName: "person.crop.circle")
                                        .font(.system(size: 40))
                                        .foregroundColor(vm.findCachedUser(id: friend.id ?? "Unknown").isActive ? .green : .red)
                                        .opacity(0.6)
                                    
                                        Text(friend.wrappedName)
                                            .font(.headline)
                                }
                                .foregroundColor(.secondary)
                            }
                        }
                        .padding(5)
                    }
                }
                }
                .frame(height: 75)
                .padding(.vertical)
                .background(.thinMaterial)
                .cornerRadius(15)
                .padding(10)
                
                Text(user.wrappedAbout)
                    .font(.system(size: 16))
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(15)
                    .padding(10)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical)
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding(10)
        }
    }
        .background(Color(red: 0.35, green: 0.45, blue: 0.8))
        .ignoresSafeArea()
        .navigationTitle(user.wrappedName)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
    func ageEmoji() -> String {
        var age = ""
        switch user.age {
        case 0...12 :
            age = "👶"
        case 12...20 :
            age = "👦"
        case 20...35 :
            age = "👨"
        default :
            age = "👴"
        }
        return age
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(users: Users(), user: User(id: "yes", isActive: true, name: "name", age: 1, company: "yes", email: "yes", address: "yes", about: "yes", friends: [Friend]()))
//    }
//}
