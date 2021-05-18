//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kazi Abdullah Al Mamun on 5/18/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showAnswer = false
    @State private var score = 0
    @State private var questionAnswered = 0
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                ForEach( 0 ..< 3) { number in
                    Button(action: {
                        self.calculateAns(ans: number)
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    })
                }
                
                Text("Score: \(score) out of \(questionAnswered)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showAnswer, content: {
            Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue"), action: {
                self.shuffleQuestion()
            }))
        })
    }
    
    private func calculateAns(ans: Int) {
        questionAnswered += 1
        
        if ans == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            alertMessage = "Your score is \(score) out of \(questionAnswered)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "You selected Flag of \(countries[ans])"
        }
        
        showAnswer = true
    }
    
    private func shuffleQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
