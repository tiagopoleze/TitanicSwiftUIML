//
//  ContentView.swift
//  TitanicSwiftUIML
//
//  Created by Tiago Ferreira on 26/05/20.
//  Copyright © 2020 Tiago Ferreira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var pclass = "3"
    @State private var age = "36"
    @State private var sex = "male"
    
    var sexs = ["male", "female"]
    var pclasses = ["1", "2", "3"]
    
    @State private var result = 0.00
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Passager class")) {
                    Picker(selection: $pclass, label: Text("\(pclass)")) {
                        ForEach(pclasses, id: \.self) {
                            Text("\($0)º")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
                Section(header: Text("Choose your sex")) {
                    Picker(selection: $sex, label: Text("\(sex)")) {
                        ForEach(sexs, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Put your age")) {
                    TextField("\(age)", text: $age)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Classify button")) {
                    Button(action: {
                        self.calculatePercentual()
                    }) {
                        Text("Press to classify")
                    }
                }
                
                Section(header: Text("Percentual")) {
                    Text("\(result, specifier: "%.2f") %")
                }
            }
        .navigationBarTitle("Titanic SwiftUI+ML")
        }
    }
    
    func calculatePercentual() {
        let model = Titanic()
        
        if let pclass = Double(pclass) {
            if let age = Double(age) {
                do {
                    let prediction = try model.prediction(Pclass: pclass, Sex: sex, Age: age)
                    let probs = prediction.SurvivedProbability
                    if let prob = probs[1] {
                        result = prob
                    }
                } catch  {
                    fatalError("\(error)")
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
