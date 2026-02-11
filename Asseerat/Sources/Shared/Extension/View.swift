//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import SwiftUI
import PanModal

extension View {
    public func presentModal<Content: View>(displayPanModal: Binding<Bool>, viewHeight:CGFloat = (biometricType() == .face ? 0.4 : 0.5), @ViewBuilder content: @escaping () -> Content) -> some View {
            
        self.onChange(of: displayPanModal.wrappedValue) { _, newValue in
            let topMostController = self.topMostController()
            if (newValue && !topMostController.isPanModalPresented) {
                DispatchQueue.main.async {
                    let vc = BottomPopUpView(rootView: content())
                    vc.viewHeight = viewHeight
                    vc.needDismiss = displayPanModal
                    topMostController.presentPanModal(vc)
                }
            }
        }
    }
    
    public func topMostController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first,
                  let window = windowScene.windows.filter({ $0.isKeyWindow }).first,
                  let rootController = window.rootViewController else {
                fatalError("No key window or root view controller found")
            }
            
        var topController: UIViewController = rootController
        while let presentedController = topController.presentedViewController {
            topController = presentedController
        }
            
        return topController
    }
}

public extension View {
    func onDidLoad(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> ()
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}

enum ImpactGenerator {
    case panModal
    func generateImpact() {
        switch self {
        case .panModal:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}
