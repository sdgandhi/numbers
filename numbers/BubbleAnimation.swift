//
//  BubbleAnimation.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

struct BubbleAnimation: GeometryEffect {
    var amount: CGFloat = 0.1
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let scale = 1 + amount * abs(sin(animatableData * .pi))
        return ProjectionTransform(CGAffineTransform(scaleX: scale, y: scale))
    }
}
