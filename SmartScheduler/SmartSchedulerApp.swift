//
//  SmartSchedulerApp.swift
//  SmartScheduler
//
//  Created by Bogeun Kim on 2022/05/10.
//

import SwiftUI

@main
struct SmartSchedulerApp: App {
    
    @StateObject private var dataController = DataController()
    @FetchRequest(sortDescriptors: []) var schedule: FetchedResults<Schedule>
    @Environment(\.managedObjectContext) var moc
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
