//
//  ContentView.swift
//  Milestone4
//
//  Created by admin on 26.08.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject private var vm = DataController()
    @StateObject private var users = Users()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(vm.savedEntities) { user in
                        NavigationLink {
                            DetailView(vm: vm, user: user)
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 40))
                                
                                VStack(alignment: .leading) {
                                    Text(user.wrappedName)
                                        .font(.headline)
                                    
                                    Text("\(user.wrappedAge)")
                                        .font(.subheadline)
                                }
                                Spacer()
                                Circle()
                                    .fill(user.isActive ? Color.green : Color.pink)
                                    .frame(width: 30, height: 30)
                                    .offset(x: 10, y: 0)
                                    .opacity(0.6)
                                    .padding()
                            }
                        }
                    }
                }
                .task {
                    await vm.addToCoreData()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
