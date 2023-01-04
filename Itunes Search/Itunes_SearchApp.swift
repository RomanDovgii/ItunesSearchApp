//
//  Itunes_SearchApp.swift
//  Itunes Search
//
//  Created by Roman Dovgii on 1/4/23.
//

import SwiftUI

@main
struct Itunes_SearchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
