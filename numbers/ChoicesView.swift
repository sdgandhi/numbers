//
//  ChoicesView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI


struct ChoicesView: View {
    
    var confirmationDuration = 1.5
    var answerGenerator = AnswerGenerator()
    var feedbackGenerator = UINotificationFeedbackGenerator()
    var timeLimit: Double = 4
    static var timer: Timer? // don't re-render when we set this, so static
    @ObservedObject var numberGenerator = NumberGenerator()
    @State var answerStatus: AnswerStatus = .unknown
    @State var wrongAttempts: Int = 0 // used only for animation interpolation
    @State var rightAttempts: CGFloat = 0 // used only for animation interpolation
    @State var timerViewScale: CGFloat = 1
    @State var combo = 0
    
    var body: some View {
        let number = numberGenerator.number!.number
        let numberString = String(number)
        let answers = answerGenerator.generate(number: number)
        
        return ZStack {
            Rectangle()
                .fill(Color(UIColor.systemBackground))
            Rectangle()
                .fill(Color(UIColor.secondarySystemBackground))
                .scaleEffect(x: 1, y: timerViewScale, anchor: .bottom)
            VStack {
                Text("\(String(repeating: "⭐️", count: self.combo))")
                    .padding(10)
                    .font(.system(.body, design: .monospaced))
                    .background(Color(UIColor.tertiarySystemFill))
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .cornerRadius(.greatestFiniteMagnitude)
                    .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(self.combo)))
                Spacer()
                HStack(spacing: 0) {
                    ForEach(0..<numberString.count, id: \.self) { index in
                        Text(String(numberString[numberString.index(numberString.startIndex, offsetBy: index)]))
                            .frame(maxWidth: .infinity)
                            .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(self.rightAttempts)))
                            .animation(Animation.spring().delay(Double(index)/10.0))
                    }
                }
                .modifier(ShakeAnimation(amount: 25, shakesPerUnit: 3, animatableData: CGFloat(self.wrongAttempts)))
                .font(.system(size: 72, weight: .bold, design: .monospaced))
                .padding(.horizontal)
                Spacer()
                Text("What's the number?")
                    .padding(.bottom)
                VStack(spacing: 12) {
                    ForEach(answers, id: \.self) { ans in
                        Button("\(ans)") {
                            if (ans == NumberWords(string: String(number))) {
                                self.answerStatus = .correct
                                self.rightAttempts += 1
                                self.combo += 1
                                ChoicesView.timer?.invalidate()
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                                    self.answerStatus = .unknown
                                    self.numberGenerator.generate()
                                    self.timerViewScale = 1
                                    withAnimation(.linear(duration: self.timeLimit)) {
                                        self.timerViewScale = 0
                                    }
                                    ChoicesView.timer = Timer.scheduledTimer(withTimeInterval: self.timeLimit, repeats: false) { _ in
                                        withAnimation(.none) { self.combo = 0 }
                                    }
                                }
                            } else {
                                self.answerStatus = .incorrect
                                self.wrongAttempts += 1
                                withAnimation(.none) { self.combo = 0 }
                                self.feedbackGenerator.notificationOccurred(.error)
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                                    self.answerStatus = .unknown
                                }
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
            .background(answerStatus == .correct ? Color.green : answerStatus == .incorrect ? Color.red : Color.clear)
            .animation(.easeInOut)
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
