//
//  MainView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ChoicesView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Choices")
                }
            SpeechRecognitionView()
                .tabItem {
                    Image(systemName: "mic")
                    Text("Speech")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
