//
//  macOSTestApp.swift
//  macOSTest
//
//  Created by 한지석 on 2023/07/11.
//

import SwiftUI

@main
struct macOSTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
