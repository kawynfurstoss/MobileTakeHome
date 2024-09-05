//
//  BottomModal.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI

struct BottomModalModifier<Modal>: ViewModifier where Modal: View {
    @Binding var shouldDisplay: Bool
    var onDismissed: () -> Void
    let modal: () -> Modal
    
    init(shouldDisplay: Binding<Bool>, onDismissed: @escaping () -> Void, @ViewBuilder modal: @escaping () -> Modal) {
        self._shouldDisplay = shouldDisplay
        self.onDismissed = onDismissed
        self.modal = modal
    }
    
    func body(content: Content) -> some View {
        content.overlay(
            VStack {
                Spacer()
                if shouldDisplay {
                    VStack {
                        modal()
                    }
                    .padding(.bottom, Padding.extraLarge * 2)
                    .frame(height: 320)
                    .foregroundColor(.white)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 5)
                    .transition(AnyTransition.move(edge: .bottom))
                    .onTapGesture {
                        withAnimation {
                            shouldDisplay = false
                            onDismissed()
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { _ in
                                withAnimation {
                                    shouldDisplay = false
                                    onDismissed()
                                }
                            }
                    )
                }
            }
        )
        .ignoresSafeArea()
    }
}
