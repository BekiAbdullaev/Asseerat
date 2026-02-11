//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import Foundation
import UIKit
import SwiftUI
import PanModal

@MainActor
class BottomPopUpView<Content>: UIHostingController<Content>, @preconcurrency PanModalPresentable where Content: View {
    var viewHeight: CGFloat = 0.0
    public var needDismiss: Binding<Bool> = .constant(false)
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var cornerRadius: CGFloat {
        return 20
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(UIScreen.main.bounds.height * viewHeight)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(UIScreen.main.bounds.height * viewHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.setBackColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.panModalSetNeedsLayoutUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: true) {
            self.needDismiss.wrappedValue = false
        }
    }
    
    public func onSelected(index: Int, state: Int) {
        dismiss(animated: true) {
            self.needDismiss.wrappedValue = false
        }
    }
}
