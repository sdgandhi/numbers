//
//  SpeechSynthesizer.swift
//  numbers
//
//  Created by Sidhant Gandhi on 6/20/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import AVFoundation

struct SpeechSynthesizer {
    private static var synthesizer = AVSpeechSynthesizer()
    
    static func say(_ say: String) {
        synthesizer.usesApplicationAudioSession = true
        if synthesizer.isSpeaking { return }
        let utterance = AVSpeechUtterance(string: say)
        SpeechSynthesizer.synthesizer.speak(utterance)
    }
}
