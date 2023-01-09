//
//  ContentView.swift
//  WeSplit
//
//  Created by MAC on 26/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: Double?
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    //--------------------------------------
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let orderAmount = checkAmount ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    //--------------------------------------
    var totalValue : Double {
        let tipSelection = Double(tipPercentage)
        let orderAmount = checkAmount ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
    //--------------------------------------
                Section {
                    TextField("Enter Bill Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
    //--------------------------------------
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    } .pickerStyle(.segmented)
                }header: {
                    Text("How much tip do you want to leave?")
                }
    //--------------------------------------
                Section {
                        Text(totalValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }header: {
                    Text("Total Bill")
                }
    //--------------------------------------
                            Section {
                                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            }header: {
                                Text("Amount Per Person:")
                            }
    //--------------------------------------
                    
            } .navigationTitle("WeSplit")
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
