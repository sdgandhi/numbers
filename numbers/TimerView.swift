//
//  TimerView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 6/28/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timedAnswers: TimedAnswers

    var body: some View {
        return ZStack {
            Rectangle()
                .fill(Color(UIColor.secondarySystemBackground))
                .scaleEffect(x: 1, y: timedAnswers.countdown, anchor: .bottom)
            Rectangle()
                .fill(timedAnswers.answerStatus == .correct ? Color.green : timedAnswers.answerStatus == .incorrect ? Color.red : Color.clear)
                .animation(.easeInOut)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timedAnswers: TimedAnswers())
    }
}
