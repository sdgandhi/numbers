//
//  ChoicesView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI


struct ChoicesView: View {
    
    var answerGenerator = AnswerGenerator()
    var feedbackGenerator = UINotificationFeedbackGenerator()
    @ObservedObject var numberGenerator = NumberGenerator()
    @ObservedObject var timedAnswers = TimedAnswers()
    
    var body: some View {
        let number = numberGenerator.number!.number
        let numberString = String(number)
        let answers = answerGenerator.generate(number: number)
        return ZStack {
            TimerView(timedAnswers: timedAnswers)
            VStack {
                ComboView(combo: timedAnswers.combo)
                Spacer()
                HStack(spacing: 0) {
                    ForEach(0..<numberString.count, id: \.self) { index in
                        Text(String(numberString[numberString.index(numberString.startIndex, offsetBy: index)]))
                            .frame(maxWidth: .infinity)
                            .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(self.timedAnswers.rightAttempts)))
                            .animation(Animation.spring().delay(Double(index)/10.0))
                    }
                }
                .modifier(ShakeAnimation(amount: 25, shakesPerUnit: 3, animatableData: CGFloat(timedAnswers.wrongAttempts)))
                .font(.system(size: 72, weight: .bold, design: .monospaced))
                .padding(.horizontal)
                Spacer()
                Text("What's the number?")
                    .padding(.bottom)
                VStack(spacing: 12) {
                    ForEach(answers, id: \.self) { ans in
                        Button("\(ans)") {
                            if (ans == NumberWords(string: String(number))) {
                                self.timedAnswers.correct()
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.timedAnswers.confirmationDuration) {
                                    self.numberGenerator.generate()
                                    self.timedAnswers.reset()
                                }
                            } else {
                                self.timedAnswers.incorrect()
                                self.feedbackGenerator.notificationOccurred(.error)
                            }
                        }
                        .buttonStyle(BlockButton())
                        .accessibility(identifier: ans)
                    }
                }
                .padding()
                Spacer()
            }
            .padding(.top, 100)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChoicesView()
                .environment(\.colorScheme, .dark)
        }
    }
}
