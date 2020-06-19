//
//  TypeInView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 6/7/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

struct TypeInView: View {
    
    var confirmationDuration = 1.5
    var feedbackGenerator = UINotificationFeedbackGenerator()
    var timeLimit: Double = 4
    static var timer: Timer? // don't re-render when we set this, so static
    
    @ObservedObject var numberGenerator = NumberGenerator()
    @State var answerStatus: AnswerStatus = .unknown
    @State var wrongAttempts: Int = 0 // used only for animation interpolation
    @State var rightAttempts: CGFloat = 0 // used only for animation interpolation
    @State var timerViewScale: CGFloat = 1
    @State var combo = 0
    @State var answer: String = ""
    
    var body: some View {
        let numberWords = numberGenerator.number!.numberWords
        let correctAnswer = numberGenerator.number!.number
        
        let answerBinding = Binding<String>(get: {
            self.answer
        }, set: {
            guard ($0 == String(correctAnswer)) else {
                self.answer = $0
                return
            }
            
            self.answerStatus = .correct
            self.rightAttempts += 1
            self.combo += 1
            TypeInView.timer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                self.answer = ""
                self.answerStatus = .unknown
                self.numberGenerator.generate()
                self.timerViewScale = 1
                withAnimation(.linear(duration: self.timeLimit)) {
                    self.timerViewScale = 0
                }
                TypeInView.timer = Timer.scheduledTimer(withTimeInterval: self.timeLimit, repeats: false) { _ in
                    withAnimation(.none) {
                        self.answer = ""
                        self.answerStatus = .unknown
                        self.numberGenerator.generate()
                        self.timerViewScale = 1
                        self.combo = 0
                    }
                }
            }
        })
        
        return ZStack {
            Rectangle()
                .fill(Color(UIColor.systemBackground))
            Rectangle()
                .fill(Color(UIColor.secondarySystemBackground))
                .scaleEffect(x: 1, y: timerViewScale, anchor: .bottom)
            VStack {
                Text("Combo \(self.combo)")
                    .padding(10)
                    .font(.system(.body, design: .monospaced))
                    .background(Color(UIColor.tertiarySystemFill))
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .cornerRadius(.greatestFiniteMagnitude)
                    .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(self.combo)))
                    .modifier(ShakeAnimation(amount: 25, shakesPerUnit: 3, animatableData: CGFloat(self.wrongAttempts)))
                    .padding(.horizontal)
                Text("What's the number?")
                    .padding(.vertical, 30)
                Text("\(numberWords)")
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 30)
                HStack(spacing: 0) {
                    ForEach(0..<self.answer.count, id: \.self) { index in
                        Text(String(self.answer[self.answer.index(self.answer.startIndex, offsetBy: index)]))
                            .font(.system(.title, design: .monospaced))
                            .frame(maxWidth: .infinity)
                            .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(self.rightAttempts)))
                            .animation(Animation.spring().delay(Double(index)/10.0))
                    }
                }
                VStack(spacing: 12) {
                    ResponderTextField("", text: answerBinding, isFirstResponder: .constant(true)) { textField in
                        textField.adjustsFontForContentSizeCategory = true
                        textField.enablesReturnKeyAutomatically = true
                        textField.keyboardType = .numberPad
                    }
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .frame(height: 0, alignment: .center)
                    .background(Color.gray)
                    .cornerRadius(10)
                    
                    //                    TextField("Answer", text: self.$answer, onEditingChanged: { (something: Bool) in
                    //
                    //                    }) {
                    //                        // on commig
                    //                    }
                    //                    ForEach(answers, id: \.self) { ans in
                    //                        Button(action: {
                    //                            if (ans == NumberWords(string: String(number))) {
                    //                                self.answerStatus = .correct
                    //                                self.rightAttempts += 1
                    //                                self.combo += 1
                    //                                ChoicesView.timer?.invalidate()
                    //                                DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                    //                                    self.answerStatus = .unknown
                    //                                    self.numberGenerator.generate()
                    //                                    self.timerViewScale = 1
                    //                                    withAnimation(.linear(duration: self.timeLimit)) {
                    //                                        self.timerViewScale = 0
                    //                                    }
                    //                                    ChoicesView.timer = Timer.scheduledTimer(withTimeInterval: self.timeLimit, repeats: false) { _ in
                    //                                        withAnimation(.none) { self.combo = 0 }
                    //                                    }
                    //                                }
                    //                            } else {
                    //                                self.answerStatus = .incorrect
                    //                                self.wrongAttempts += 1
                    //                                withAnimation(.none) { self.combo = 0 }
                    //                                self.feedbackGenerator.notificationOccurred(.error)
                    //                                DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                    //                                    self.answerStatus = .unknown
                    //                                }
                    //                            }
                    //                        }) {
                    //                            Text(ans)
                    //                                .frame(maxWidth: .infinity)
                    //                                .padding()
                    //                                .background(Color.accentColor)
                    //                                .foregroundColor(Color.white)
                    //                                .cornerRadius(12)
                    //                        }
                    //                        .accessibility(identifier: ans)
                    //                    }
                }
                .padding()
                Spacer()
            }
            .padding(.top, 50)
            .background(answerStatus == .correct ? Color.green : answerStatus == .incorrect ? Color.red : Color.clear)
            .animation(.easeInOut)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func textFieldDidChange() {
        
    }
}

struct TypeInView_Previews: PreviewProvider {
    static var previews: some View {
        TypeInView()
            .environment(\.colorScheme, .dark)
    }
}
