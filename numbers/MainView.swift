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
    @ObservedObject var recognizedSpeech = RecognizedSpeech()

    var body: some View {
        VStack {
            Text("Numbers")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(.bottom, 64.0)
            HStack {
                Text("3")
                Text("8")
                Text("2")
                Text("4")
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
            Text(recognizedSpeech.text ?? " ")
                .font(.title)
                .fontWeight(.black)
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
                            try self.recognizedSpeech.activate()
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
