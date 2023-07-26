//
//  ControlsView.swift
//  myWorkouts Watch App
//
//  Created by Foysal on 7/14/23.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var workoutManger: WorkoutManager
    var body: some View {
        HStack {
            VStack {
                Button {
                    workoutManger.endWorkoutSession()
                }label: {
                        Image(systemName: "xmark")
                }
                .tint(.red)
                .font(.title2)
                Text("End")
            }
            VStack {
                Button {
                    workoutManger.togglePause()
                }label: {
                    Image(systemName: workoutManger.running ?  "pause" : "play")
                }
                .tint(.yellow)
                .font(.title2)
                Text(workoutManger.running ? "Pause" : "Resume")
            }
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView().environmentObject(WorkoutManager())
    }
}
