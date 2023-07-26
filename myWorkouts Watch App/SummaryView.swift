//
//  SummaryView.swift
//  myWorkouts Watch App
//
//  Created by Foysal on 7/14/23.
//
import Foundation
import HealthKit
import SwiftUI
import WatchKit

struct SummaryView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    var body: some View {
        if workoutManager.workout == nil {
            ProgressView("Saving workout")
                .navigationBarHidden(true)
            
        }else {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    SummaryMetricsView(title: "Total Time", value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0) ?? "")
                        .accentColor(.yellow)
                    SummaryMetricsView(title: "Total Distance", value: Measurement(value: workoutManager.workout?.totalDistance?.doubleValue(for: .meter()) ?? 0 , unit: UnitLength.meters).formatted(
                        .measurement(width: .abbreviated,usage: .road)))
                        .accentColor(.green)
                    SummaryMetricsView(title: "Total Energy", value: Measurement(value: workoutManager.workout?.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0, unit: UnitLength.meters).formatted(
                        .measurement(width: .abbreviated,usage: .road,numberFormatStyle: .number.precision(.fractionLength(0)))))
                        .accentColor(.pink)
                    
                    SummaryMetricsView(title: "Avg. Hear Rate", value: workoutManager.averageHearRate.formatted(
                        .number.precision(.fractionLength(0))) + " bpm")
                        .accentColor(.red)
                    
                    Text("Activity Rings")
                    ActivityRingsView(healthStore: workoutManager.healthStore)
                        .frame(width: 50,height: 50)
                    Button("Done"){
                        dismiss()
                    }
                }.scenePadding()
            }.navigationTitle("Summary")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}

struct SummaryMetricsView: View {
    var title: String
    var value: String
    
    var body: some View {
        Text(title)
        Text(value)
            .font(.system(.title2,design: .rounded).lowercaseSmallCaps())
            .foregroundColor(.accentColor)
        Divider()
    }
}
