//
//  TypeInView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 6/7/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI
import Combine
import Introspect

struct TypeInView: View {
    var feedbackGenerator = UINotificationFeedbackGenerator()
    @ObservedObject var numberGenerator = NumberGenerator()
    @ObservedObject var timedAnswers = TimedAnswers()
    
    @State var answer: String = ""
    @State var speak: Bool = false
    @State var keyboardHeight: CGFloat = 0
    
    var body: some View {
        let numberWords = numberGenerator.number!.numberWords
        let correctAnswer = numberGenerator.number!.number
        
        return ZStack(alignment: .bottom) {
            TimerView(timedAnswers: timedAnswers)
            VStack(alignment: .center, spacing: 30) {
                Toggle(isOn: $speak) {
                    Image(systemName: "speaker.2")
                }
                .frame(maxWidth: 0)
                .padding()
                Spacer()
                Text("\(numberWords)")
                    .frame(maxHeight: .infinity)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        SpeechSynthesizer.say(self.numberGenerator.number!.numberWords)
                }
                TextField("", text: $answer)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 28, design: .monospaced))
                    .frame(height: 70)
                    .modifier(BubbleAnimation(amount: 0.1, animatableData: CGFloat(self.timedAnswers.rightAttempts)))
                    .accentColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 4)
                )
                    .introspectTextField { textField in
                        textField.enablesReturnKeyAutomatically = true
                        textField.keyboardType = .numberPad
                        textField.becomeFirstResponder()
                }
                Button("Enter") {
                    if (self.answer == String(correctAnswer)) {
                        self.timedAnswers.correct()
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.timedAnswers.confirmationDuration) {
                            self.answer = ""
                            self.numberGenerator.generate()
                            if self.speak {
                                SpeechSynthesizer.say(self.numberGenerator.number!.numberWords)
                            }
                            self.timedAnswers.reset()
                        }
                    } else {
                        self.timedAnswers.incorrect()
                        self.feedbackGenerator.notificationOccurred(.error)
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.timedAnswers.confirmationDuration) {
                            self.answer = ""
                        }
                    }
                }
                .buttonStyle(BlockButton())
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 1, height: max(self.keyboardHeight - 50, 0), alignment: .bottom)
            }
            .padding()
        }
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

struct TypeInView_Previews: PreviewProvider {
    static var previews: some View {
        TypeInView()
    }
}
