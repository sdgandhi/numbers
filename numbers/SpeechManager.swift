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
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer()
    private var inputNode: AVAudioInputNode?
    private let audioSession = AVAudioSession.sharedInstance()
    
    var update: ((String) -> Void)?
    
    func reset() throws {
        print("Speech manager resetting")
        update?("")
        recognitionTask?.cancel()
        inputNode?.removeTap(onBus: 0)
        
        // Configure the microphone input.
        guard let inputNode = inputNode else {
            throw SpeechManagerError.AudioInputNodeUnavailable
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        // Configure the recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let request = recognitionRequest else {
            throw SpeechManagerError.SpeechRecognitionRequestUnavailable
        }
        request.shouldReportPartialResults = true
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        guard let recognizer = speechRecognizer else {
            throw SpeechManagerError.SpeechRecognizerUnavailable
        }
        
        recognizer.defaultTaskHint = .dictation
        
        recognitionTask = recognizer.recognitionTask(with: request) { result, error in
            if let error = error {
                print("Speech Manager error: \(error.localizedDescription)")
            }
            if let result = result {
                print("-----")
                print(result.transcriptions)
                self.update?(result.bestTranscription.formattedString)
            }
        }
    }
    
    func deactivate() throws {
        print("Speech manager deactivating")
        self.audioEngine.stop()
        inputNode?.removeTap(onBus: 0)
        try audioSession.setActive(false)
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
    }
    
    func activate() throws {
        print("Speech manager activating")
        // Configure the audio session for the app.
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        inputNode = audioEngine.inputNode
        
        try reset()

        audioEngine.prepare()
        try audioEngine.start()
    }
}

enum SpeechManagerError: Error {
    case SpeechRecognitionRequestUnavailable
    case SpeechRecognizerUnavailable
    case AudioInputNodeUnavailable
}
