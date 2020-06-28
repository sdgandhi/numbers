//
//  ComboView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 6/28/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

struct ComboView: View {
    var combo: Int = 0
    
    var body: some View {
        Text("\(String(repeating: "⭐️", count: combo))")
        .padding(10)
        .font(.system(.body, design: .monospaced))
        .background(Color(UIColor.tertiarySystemFill))
        .foregroundColor(Color(UIColor.tertiaryLabel))
        .cornerRadius(.greatestFiniteMagnitude)
        .modifier(BubbleAnimation(amount: 0.2, animatableData: CGFloat(combo)))
    }
}

struct ComboView_Previews: PreviewProvider {
    static var previews: some View {
        ComboView(combo: 4)
    }
}
