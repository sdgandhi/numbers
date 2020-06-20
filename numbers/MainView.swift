//
//  MainView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

enum GameType {
    case Choices
    case TypeIn
}

struct MainView: View {
    @State var showGame: Bool = false
    @State var game: GameType = .Choices
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Spacer()
            Button("Choices") {
                self.game = .Choices
                self.showGame = true
            }.buttonStyle(CircleButton(width: 100))
            Spacer()
            Button("Type In") {
                self.game = .TypeIn
                self.showGame = true
            }.buttonStyle(CircleButton(width: 100))
            Spacer()
        }
        .sheet(isPresented: $showGame) {
            if self.game == .Choices {
                ChoicesView()
            } else if self.game == .TypeIn {
                TypeInView()
            }
        }
//        TabView {
//            ChoicesView()
//                .tabItem {
//                    Image(systemName: "list.dash")
//                    Text("Choices")
//            }
//            TypeInView()
//                .tabItem {
//                    Image(systemName: "pencil.and.ellipsis.rectangle")
//                    Text("Type In")
//            }
//            SpeechRecognitionView()
//                .tabItem {
//                    Image(systemName: "mic")
//                    Text("Speech")
//            }
//        }
//        .accentColor(Color.blue)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
