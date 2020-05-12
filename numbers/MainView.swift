//
//  ContentView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/11/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI
import Speech

struct MainView: View {
    @ObservedObject var speechRecognizer = SpeechRecognizer()
    @ObservedObject var numberGenerator = NumberGenerator()
    @State var isStarted = true
    
    var body: some View {
        VStack {
            Text("Numbers")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(.bottom, 64.0)
            HStack {
                Text(String(numberGenerator.number?.number ?? 0))
            }
            .font(.largeTitle)
            Spacer()
            Image(systemName: "mic")
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(UIColor.systemGray))
            Text("Say the number...")
                .padding(.bottom)
                .foregroundColor(Color(UIColor.systemGray))
            VStack<Text> {
                if (speechRecognizer.text == numberGenerator.number?.numberWords) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        try? self.speechRecognizer.reset()
                        self.numberGenerator.generate()
                    }
                }
                return Text(speechRecognizer.text ?? " ")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(Color(speechRecognizer.text == numberGenerator.number?.numberWords ? UIColor.systemGreen : UIColor.systemYellow))
            }
            Button(self.isStarted ? "Stop" : "Start") {
                self.isStarted ? try? self.speechRecognizer.deactivate() : try? self.speechRecognizer.activate()
            }
            Spacer()
        }
        .padding(.vertical)
        .onAppear {
            SFSpeechRecognizer.requestAuthorization { authStatus in
                // The authorization status results in changes to the
                // app’s interface, so process the results on the app’s
                // main queue.
                OperationQueue.main.addOperation {
                    switch authStatus {
                    case .authorized:
                        print("authorized for speech recognition")
                        do {
                            try self.speechRecognizer.activate()
                        } catch {
                            print("ERROR \(error.localizedDescription)")
                        }
                    case .denied: fallthrough
                    case .restricted:
                        print("denied speech recognition access")
                    case .notDetermined:
                        print("speech recognition access not determined")
                    @unknown default:
                        fatalError()
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
