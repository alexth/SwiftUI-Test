//
//  AnimationCompletionObserverModifier.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 23.11.2021.
//

import SwiftUI

struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {

    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    private var targetValue: Value

    private var completion: () -> Void

    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }
    
    func body(content: Content) -> some View { content }

    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }

        DispatchQueue.main.async {
            self.completion()
        }
    }
}
