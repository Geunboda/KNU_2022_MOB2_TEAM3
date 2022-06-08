//
//  SmartSchedulerApp.swift
//  SmartScheduler
//
//  Created by Bogeun Kim on 2022/05/10.
//

import SwiftUI
import CoreData

@main
struct SmartSchedulerApp: App {
    

    @StateObject private var dataController = DataController()    
    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
