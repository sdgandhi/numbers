//
//  SpeechRecognizer.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/12/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation
import Combine

final class SpeechRecognizer: ObservableObject  {
    var speechManager: SpeechManager
    
    @Published var text: String?
    
    init() {
        self.speechManager = SpeechManager()
        speechManager.update = { recognized in
            print("recognized: \(recognized)")
            let numberWords = NumberWords(string: recognized)
            self.text = numberWords
        }
    }
    
    func activate() throws {
        try speechManager.activate()
    }
    
    func deactivate() throws {
        try speechManager.deactivate()
    }
    
    func reset() throws {
        try speechManager.reset()
    }
}
