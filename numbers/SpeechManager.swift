//
//  SpeechManager.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/12/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation
import AVFoundation
import Speech

class SpeechManager {
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer()
    private var inputNode: AVAudioInputNode?
    private let audioSession = AVAudioSession.sharedInstance()
    
    var update: ((String) -> Void)?
    
    func deactivate() throws {
        self.audioEngine.stop()
        inputNode?.removeTap(onBus: 0)
        try audioSession.setActive(false)
        self.recognitionRequest = nil
        self.recognitionTask = nil
    }
    
    func activate() throws {
        guard let recognitionRequest = recognitionRequest else {
            throw SpeechManagerError.SpeechRecognitionRequestUnavailable
        }
        
        // Configure recognition request
        recognitionRequest.shouldReportPartialResults = true
        
        // Configure the audio session for the app.
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        inputNode = audioEngine.inputNode
        
        // Configure the microphone input.
        guard let inputNode = inputNode else {
            throw SpeechManagerError.AudioInputNodeUnavailable
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            recognitionRequest.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        guard let speechRecognizer = speechRecognizer else {
            throw SpeechManagerError.SpeechRecognizerUnavailable
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.update?(result.bestTranscription.formattedString)
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                try? self.deactivate()
            }
        }
    }
}

enum SpeechManagerError: Error {
    case SpeechRecognitionRequestUnavailable
    case SpeechRecognizerUnavailable
    case AudioInputNodeUnavailable
}
