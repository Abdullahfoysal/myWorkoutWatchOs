//
//  SessionPaginView.swift
//  myWorkouts Watch App
//
//  Created by Foysal on 7/14/23.
//

import SwiftUI
import WatchKit


struct SessionPaginView: View {
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case controls, metrics, nowPlaying
    }
    var body: some View {
        TabView(selection: $selection) {
           ControlsView().tag(Tab.controls)
           MetricsView().tag(Tab.metrics)
           NowPlayingView().tag(Tab.nowPlaying)
        }.navigationTitle(workoutManager.selectedWorkout?.name ?? "")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(selection == .nowPlaying)
            .onChange(of: workoutManager.running) { _ in
                displayMetricsView()
                
            }
            .tabViewStyle(
            PageTabViewStyle(
                indexDisplayMode: isLuminanceReduced ? .never : .automatic)
            ).onChange(of: isLuminanceReduced) { _ in
                displayMetricsView()
            }
    }
    
    private func displayMetricsView(){
        withAnimation {
            selection = .metrics
        }
    }
    
}

struct SessionPaginView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPaginView().environmentObject(WorkoutManager())
    }
}
