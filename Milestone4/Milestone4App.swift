//
//  Milestone4App.swift
//  Milestone4
//
//  Created by admin on 26.08.2022.
//

import SwiftUI

@main
struct Milestone4App: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
