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
    var answerGenerator = AnswerGenerator()
    @ObservedObject var numberGenerator = NumberGenerator()
    @State var answerStatus: AnswerStatus = .unknown

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
            HStack {
                Text(String(number))
            }
            .font(.largeTitle)
            Spacer()
            Text("Choose the number")
                .padding(.bottom)
                .foregroundColor(Color(UIColor.systemGray))
            VStack(spacing: 12) {
                ForEach(answers, id: \.self) { ans in
                    Button(action: {
                        if (ans == NumberWords(string: String(number))) {
                            self.answerStatus = .correct
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.answerStatus = .unknown
                                self.numberGenerator.generate()
                            }
                        } else {
                            self.answerStatus = .incorrect
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
//                    .modifier(Shake())
                    .accessibility(identifier: ans)
                }
            }
            .padding()
            Spacer()
        }
        .padding(.vertical, 50)
        .background(answerStatus == .correct ? Color.green : answerStatus == .incorrect ? Color.red : Color.white)
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut)
    }
}

struct ChoicesView_Previews: PreviewProvider {
    static var previews: some View {
        ChoicesView()
    }
}
