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
    
    var confirmationDuration = 1.5
    var feedbackGenerator = UINotificationFeedbackGenerator()
    //    var timeLimit: Double = 8
    //    static var timer: Timer? // don't re-render when we set this, so static
    
    @ObservedObject var numberGenerator = NumberGenerator()
    @State var answerStatus: AnswerStatus = .unknown
    @State var wrongAttempts: Int = 0 // used only for animation interpolation
    @State var rightAttempts: CGFloat = 0 // used only for animation interpolation
    //    @State var timerViewScale: CGFloat = 1
    //    @State var combo = 0
    @State var answer: String = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        let numberWords = numberGenerator.number!.numberWords
        let correctAnswer = numberGenerator.number!.number
        
        return ZStack {
            //            Rectangle()
            //                .fill(Color(UIColor.systemBackground))
            //            Rectangle()
            //                .fill(Color(UIColor.secondarySystemBackground))
            //                .scaleEffect(x: 1, y: timerViewScale, anchor: .bottom)
            VStack {
                //                Text("Combo \(self.combo)")
                //                    .padding(10)
                //                    .font(.system(.body, design: .monospaced))
                //                    .background(Color(UIColor.tertiarySystemFill))
                //                    .foregroundColor(Color(UIColor.tertiaryLabel))
                //                    .cornerRadius(.greatestFiniteMagnitude)
                //                    .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(self.combo)))
                //                    .modifier(ShakeAnimation(amount: 25, shakesPerUnit: 3, animatableData: CGFloat(self.wrongAttempts)))
                Spacer()
                Text("What's the number?")
                    .padding()
                Text("\(numberWords)")
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .onTapGesture {
                        SpeechSynthesizer.say(self.numberGenerator.number!.numberWords)
                }
                HStack(spacing: 0) {
                    ForEach(0..<self.answer.count, id: \.self) { index in
                        Text(String(self.answer[self.answer.index(self.answer.startIndex, offsetBy: index)]))
                            .font(.system(size: 32, design: .monospaced))
                            .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(self.rightAttempts)))
                            .animation(Animation.spring().delay(Double(index)/10.0))
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 75)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue, lineWidth: 4)
                )
                    .padding()
                TextField("Answer", text: $answer)
                    .frame(height: 0)
                    .opacity(0)
                    .introspectTextField { textField in
                        textField.adjustsFontForContentSizeCategory = true
                        textField.enablesReturnKeyAutomatically = true
                        textField.keyboardType = .numberPad
                        textField.becomeFirstResponder()
                    }
                Button(action: {
                    if (self.answer == String(correctAnswer)) {
                        self.answerStatus = .correct
                        self.rightAttempts += 1
                        //                        self.combo += 1
                        //                        ChoicesView.timer?.invalidate()
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                            self.answer = ""
                            self.answerStatus = .unknown
                            self.numberGenerator.generate()
                            //                            self.timerViewScale = 1
                            //                            withAnimation(.linear(duration: self.timeLimit)) {
                            //                                self.timerViewScale = 0
                            //                            }
                            //                            ChoicesView.timer = Timer.scheduledTimer(withTimeInterval: self.timeLimit, repeats: false) { _ in
                            //                                withAnimation(.none) { self.combo = 0 }
                            //                            }
                        }
                    } else {
                        self.answerStatus = .incorrect
                        self.wrongAttempts += 1
                        //                        withAnimation(.none) { self.combo = 0 }
                        self.feedbackGenerator.notificationOccurred(.error)
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                            self.answer = ""
                            self.answerStatus = .unknown
                        }
                    }
                }) {
                    Text("Enter")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                .padding()
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 1, height: self.keyboardHeight, alignment: .bottom)
            }
            .background(answerStatus == .correct ? Color.green : answerStatus == .incorrect ? Color.red : Color.clear)
            .animation(.easeInOut)
        }
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TypeInView_Previews: PreviewProvider {
    static var previews: some View {
        TypeInView()
        //            .environment(\.colorScheme, .dark)
    }
}
