//
//  ContentView.swift
//  Namta App
//
//  Created by Debashish Mondal on 4/1/22.
//

import SwiftUI
struct Question {
    var text: String
    var answer: String
}
struct ContentView: View {
    //Desired table to practice
    @State private var tableNumber = 1
    //Option number of questions
    @State private var amountQuestions = ["5", "10", "20", "All"]
    //Selected option within previous array
    @State private var questionNumber = 0
    //Array of actual questions to be asked
    @State private var questions: [Question] = []
    //Keeps track of which question is currently being asked
    @State private var questionCount = 0
    //false if asking for setting, true if game active
    @State private var gameStatus = false
    //stores user response
    @State private var userAnswer = ""
    //Stores user score
    @State private var score = 0
    //Actives alert after each response
    @State private var alertStatus = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Which table would you like to practice?")) {
                    Stepper(value: $tableNumber, in: 1...12) {
                        Text("Table of \(tableNumber)")
                    }
                }
                Section(header: Text("How many questions would you like?")) {
                    Picker(selection: $questionNumber, label: EmptyView()) {
                        ForEach(0..<4) {
                            Text("\(amountQuestions[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Button("Start!") {
                    startGame()
                    gameStatus = true
                }
                if gameStatus == true {
                    Text("\(questions[questionCount].text)")
                    TextField("Enter your answer", text: $userAnswer)
                    Button("Submit!") {
                        evaluate()
                        next()
                    }
                    Text("Your score is: \(score)")
                        .alert(isPresented: $alertStatus, content: {
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel(Text("OK")))
                        })
                    Button("Reset") {
                        reset()
                    }
                }
            }
            .navigationTitle("Multiply!")
        }
    }
    //This function creates all questions in an array of Questions struct
    func startGame() {
        let numberOfQuestions = Int(amountQuestions[questionNumber]) ?? 25
        let count = 1...numberOfQuestions
        for _ in count {
            let tempNumber = Int.random(in: 1...20)
            let tempResult = String(tableNumber * tempNumber)
            let tempQuestion = Question(text: "What is \(tableNumber) * \(tempNumber)?", answer: "\(tempResult)")
            questions.append(tempQuestion)
        }
        let finalState = Question(text: "Game completed", answer: "none")
        questions.append(finalState)
    }
    //This function checks userAnswer
    func evaluate() {
        if userAnswer == questions[questionCount].answer {
            score += 1
            alertTitle = "Good Job!"
            alertMessage = "Your score is now: \(score)"
            alertStatus = true
        } else {
            alertTitle = "Not that one, but keep trying!"
            alertMessage = "The correct answer was \(questions[questionCount].answer)"
            alertStatus = true
        }
    }
    //Provides next questions
    func next() {
        let tempTotalQuestions = Int(amountQuestions[questionNumber]) ?? 25
        if questionCount < (tempTotalQuestions - 1) {
            questionCount += 1
        } else if questionCount == (tempTotalQuestions - 1) {
            questionCount += 1
            alertTitle = "Great Job!"
            alertMessage = "Your Final Score was: \(score)"
            alertStatus = true
            //if I add reset() here I don't get the alert anymore
        }
        else {
            reset()
        }
    }
    func reset() {
        gameStatus = false
        alertStatus = false
        questions = []
        score = 0
        userAnswer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}














