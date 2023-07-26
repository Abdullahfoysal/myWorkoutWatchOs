//
//  ContentView.swift
//  myWorkouts Watch App
//
//  Created by Foysal on 7/14/23.
//

import SwiftUI
import HealthKit


struct StartView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var workoutTypes: [HKWorkoutActivityType] = [.cycling,.running,.walking]
    
    var body: some View {
        
        List(workoutTypes) { workout in
            NavigationLink(
                workout.name,
                destination: SessionPaginView(),
                tag: workout,
                selection: $workoutManager.selectedWorkout
                
            ).padding(EdgeInsets(top: 15,
                                 leading: 5, bottom: 15, trailing: 5)
            )
        }.listStyle(.carousel)
            .navigationBarTitle("Workouts")
            .onAppear {
                workoutManager.requestAuthorization()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(WorkoutManager())
    }
}


extension HKWorkoutActivityType: Identifiable {
 
    public var id: UInt {
            rawValue
       }
   
    var name: String {
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        default:
            return ""
        }
    }
}




