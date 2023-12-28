//
//  ContentView.swift
//  WeSplit
//
//  Created by Игорь Верхов on 26.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPerentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPerentage)
        let tipValue = checkAmount * tipSelection / 100
        return checkAmount + tipValue
    }
    
    var totalPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return grandTotal / peopleCount
    }
    
    let localCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: localCurrency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tips do you want to leave?") {
                    Picker("Tip percantage", selection: $tipPerentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerson, format: .currency(code: localCurrency))
                        .foregroundColor(tipPerentage == 0 ? .red : .primary)
                }
                
                Section("Total amount") {
                    Text(grandTotal, format: .currency(code: localCurrency))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
