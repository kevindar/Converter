//
//  ContentView.swift
//  converter
//
//  Created by Kevin Darmawan on 15/12/24.
//

import SwiftUI

struct ContentView: View {
    
    enum ConversionUnits: String, CaseIterable {
        case sec, min, hours, days, months, years
        var id: Self { self }
    }
    @FocusState private var inputIsFocused: Bool
    @State private var inputTime: Double = 0.0
    @State private var resultSeconds: Double = 0.0
    @State private var selectedInputUnit: ConversionUnits = .sec
    @State private var selectedOutputUnit: ConversionUnits = .min
    
    var convertedToSec: Double {
        print("input unit \(selectedInputUnit)")
        switch(selectedInputUnit) {
        case .min:
            return inputTime * 60.0
        case .hours:
            return inputTime * 3600.0
        case .days:
            return inputTime * 86_400.0
        case .months:
            return inputTime * 269_743.0
        case .years:
            return inputTime * 525599.0
        default:
            return inputTime
        }
    }
    
    
    var computedTime: Double {
        print("output unit \(selectedOutputUnit)")
        let result: Double
        switch(selectedOutputUnit) {
        case .min:
            result =  convertedToSec / 60.0
        case .hours:
            result = convertedToSec / 3600.0
        case .days:
            result = convertedToSec / 86_400.0
        case .months:
            result = convertedToSec / 2_629_743.0
        case .years:
            result = convertedToSec / 31_557_600.0
        default: // assume seconds
            result = convertedToSec
        }
        print("Computed Time: \(result)") // Debugging print statement
        return result
    }

    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter time input") {
                    Picker("Input units", selection: $selectedInputUnit) {
                        ForEach(ConversionUnits.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    // Update th e TextField binding
                    TextField("Input value", value: $inputTime, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }
                Section("Conversion results") {
                    Picker("Output units", selection: $selectedOutputUnit) {
                        ForEach(ConversionUnits.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("\(computedTime.formatted())")
                }
            }
        }
        .navigationTitle("Time Converter")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    inputIsFocused.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
