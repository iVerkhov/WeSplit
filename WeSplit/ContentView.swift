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
    
    var totalAmount: Double {
        let tipSelection = Double(tipPerentage)
        let tipValue = checkAmount * tipSelection / 100
        return checkAmount + tipValue
    }
    
    var totalPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return totalAmount / peopleCount
    }
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Hello word!", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percantage", selection: $tipPerentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tips do you want to leave?")
                }
                
                Section {
                    Text(totalPerson, format: localCurrency)
                        .foregroundColor(tipPerentage == 0 ? .red : .primary)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalAmount, format: localCurrency)
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
