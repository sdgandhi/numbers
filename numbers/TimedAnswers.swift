//
//  TimedAnswers.swift
//  numbers
//
//  Created by Sidhant Gandhi on 6/28/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation
import SwiftUI

final class TimedAnswers: ObservableObject {
    @ObservedObject var settings = Settings()
    @Published var answerStatus: AnswerStatus = .unknown
    @Published var wrongAttempts: Int = 0 // used only for animation interpolation
    @Published var rightAttempts: Int = 0 // used only for animation interpolation
    @Published var combo: Int = 0
    @Published var countdown: CGFloat = 0
    
    private var timer: Timer?
    
    var confirmationDuration: TimeInterval
    var timeLimit: TimeInterval
    
    init(confirmationDuration: TimeInterval = 1.5, timeLimit: TimeInterval = 4.0) {
        self.confirmationDuration = confirmationDuration
        self.timeLimit = timeLimit
    }
    
    func correct() {
        answerStatus = .correct
        rightAttempts += 1
        combo += 1
        guard settings.enableTimer == true else { return }
        timer?.invalidate()
    }
    
    func incorrect() {
        answerStatus = .incorrect
        wrongAttempts += 1
        combo = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + confirmationDuration) {
            self.answerStatus = .unknown
        }
    }
    
    func reset() {
        answerStatus = .unknown
        guard settings.enableTimer == true else { return }
        withAnimation(.none) {
            countdown = 1
        }
        withAnimation(.linear(duration: timeLimit)) {
            countdown = 0
        }
        timer = Timer.scheduledTimer(withTimeInterval: timeLimit, repeats: false) { _ in
            self.combo = 0
        }
    }
}
