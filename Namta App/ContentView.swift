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
    @State private var nextQuestion = 0
    @State private var tapCount = 1
    
    
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
            
            VStack{
                Text("Question Number \(tapCount) of \(questionAmount): \(tables) X \(number1) = ")
                HStack{
                    TextField("write your answer here", text: $userAnswer)
                }
            }
            
            Button("Next"){
                showingAlert = true
                tapCount += 1
            }
            .alert("Question \(asn())", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {  }
            }
            
        }
        

        
    }
    func asn() -> Int {
        var a = nextQuestion + questionAmount
        var b = a - 1
        return b
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
