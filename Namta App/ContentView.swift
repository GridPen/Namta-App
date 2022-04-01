//
//  ContentView.swift
//  Namta App
//
//  Created by Debashish Mondal on 4/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var correctAns = 0
    @State var number1 = Int.random(in: 0...10)
    @State var number2 = Int.random(in: 0...10)
    @State private var userAnswer = ""
    @State private var showingAlert = false
    @State private var tables = 2
    @State private var questionAmount = 5
    var qNumber = [5,10,20]
    
    
    var body: some View {
        VStack(spacing:20){
            VStack{
                Stepper("Select multiplication table: \(tables)", value: $tables, in: 1...20)
            }
            VStack{
                Picker("Seclect question amount", selection: $questionAmount) {
                    ForEach(qNumber, id: \.self) { qNumber in
                        Text("\(qNumber)")
                    }
                }
            }.pickerStyle(.segmented)
            
            Text("Wrire the correct Answer?")
                .font(.headline)
            
            HStack{
                Text("Math: \(tables) X \(number1) = ")
                TextField("write your answer here", text: $userAnswer)
            }
            
            HStack{
                
            }
            
            
            Button("Check"){
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            
        }
        
    }
    
    
    func MathAnswer() -> Int {
        return number1 * number2
    }
    
    func correctAnswer() {
        if MathAnswer() == Int(userAnswer) {
          
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
