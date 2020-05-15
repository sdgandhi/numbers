//
//  ChoicesView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

enum AnswerStatus {
    case correct
    case incorrect
    case unknown
}

struct ChoicesView: View {
    var confirmationDuration = 1.5
    var answerGenerator = AnswerGenerator()
    @ObservedObject var numberGenerator = NumberGenerator()
    @State var answerStatus: AnswerStatus = .unknown
    @State var wrongAttempts: Int = 0 // used only for animation interpolation
    
    var body: some View {
        let number = numberGenerator.number!.number
        let answers = answerGenerator.generate(number: number)
        
        return VStack {
            Text("Numbers")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(.bottom, 64.0)
            Text(String(number))
                .frame(maxWidth: .infinity)
                .modifier(Shake(amount: 25, shakesPerUnit: 3, animatableData: CGFloat(self.wrongAttempts)))
                .font(.system(size: 72, weight: .bold, design: Font.Design.monospaced))
            Spacer()
            Text("What's the number?")
                .padding(.bottom)
            VStack(spacing: 12) {
                ForEach(answers, id: \.self) { ans in
                    Button(action: {
                        if (ans == NumberWords(string: String(number))) {
                            self.answerStatus = .correct
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                                self.answerStatus = .unknown
                                self.numberGenerator.generate()
                            }
                        } else {
                            self.answerStatus = .incorrect
                            self.wrongAttempts += 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.confirmationDuration) {
                                self.answerStatus = .unknown
                            }
                        }
                    }) {
                        Text(ans)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(12)
                    }
                    .accessibility(identifier: ans)
                }
            }
            .padding()
            Spacer()
        }
        .padding(.vertical, 50)
        .background(answerStatus == .correct ? Color(UIColor.systemGreen) : answerStatus == .incorrect ? Color(UIColor.systemRed) : Color(UIColor.systemBackground))
        .animation(.easeInOut)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        ChoicesView()
    }
}
