//
//  ResponderView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 6/7/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

struct ResponderView<View: UIView>: UIViewRepresentable {
    @Binding var isFirstResponder: Bool
    var configuration = { (view: View) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> View { View() }

    func makeCoordinator() -> Coordinator {
        Coordinator($isFirstResponder)
    }

    func updateUIView(_ uiView: View, context: UIViewRepresentableContext<Self>) {
        context.coordinator.view = uiView
        _ = isFirstResponder ? uiView.becomeFirstResponder() : uiView.resignFirstResponder()
        configuration(uiView)
    }
}

// MARK: - Coordinator
extension ResponderView {
    final class Coordinator {
        @Binding private var isFirstResponder: Bool
        private var anyCancellable: AnyCancellable?
        fileprivate weak var view: UIView?

        init(_ isFirstResponder: Binding<Bool>) {
            _isFirstResponder = isFirstResponder
            self.anyCancellable = Publishers.keyboardHeight.sink(receiveValue: { [weak self] keyboardHeight in
                guard let view = self?.view else { return }
                DispatchQueue.main.async { self?.isFirstResponder = view.isFirstResponder }
            })
        }
    }
}

// MARK: - keyboardHeight
extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

struct ResponderView_Previews: PreviewProvider {
    static var previews: some View {
        ResponderView<UITextField>.init(isFirstResponder: .constant(false)) {
            $0.placeholder = "Placeholder"
        }.previewLayout(.fixed(width: 300, height: 40))
    }
}
