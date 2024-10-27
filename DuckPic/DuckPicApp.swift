//
//  DuckPicApp.swift
//  DuckPic
//
//  Created by Per-Arne Johansson on 2024-10-26.
//

import SwiftUI
import SwiftData

/// The main application entry point for the DuckPicApp.
@main
struct DuckPicApp: App {
    /// A shared model container used for managing the application's data.
    var sharedModelContainer: ModelContainer = {
        // Define the schema for the model container, including the Item model.
        let schema = Schema([
            Item.self,
        ])
        // Configure the model container with the schema and specify that data should be stored persistently.
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            // Attempt to create and return the model container with the given configuration.
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Terminate the application if the model container cannot be created.
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    /// The main scene of the application.
    var body: some Scene {
        WindowGroup {
            // The main content view of the application.
            ContentView()
        }
        // Attach the shared model container to the scene.
        .modelContainer(sharedModelContainer)
    }
}
