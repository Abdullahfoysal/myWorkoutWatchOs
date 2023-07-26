//
//  myWorkoutsApp.swift
//  myWorkouts Watch App
//
//  Created by Foysal on 7/14/23.
//

import SwiftUI

@main
struct myWorkouts_Watch_AppApp: App {

    @StateObject private  var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }.sheet(isPresented: $workoutManager.showingSummaryView) {
                
                SummaryView()
            }
            .environmentObject(workoutManager)
            
        }
    }
}
