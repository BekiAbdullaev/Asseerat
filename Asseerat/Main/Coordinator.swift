//
//  Coordinator.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI

public enum NavigationTranisitionStyle {
    case push
}

public enum InnerTransitionStyle{
    case presentModally
    case presentFullscreen
    case popToView
    case def
}

public protocol NavigationRouter {
    associatedtype V: View
    var transition: NavigationTranisitionStyle { get }
    @ViewBuilder
    func view() -> V
}

open class Coordinator<Router: NavigationRouter>: ObservableObject {
    public let navigationController: UINavigationController
    public let startingRoute: Router?

    public init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.navigationController.setNav()
        self.startingRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        navigate(type: route)
    }

    public func navigate(type route: Router, animated: Bool = true, style:InnerTransitionStyle = .def) {
        
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        
        if route.transition == .push{
            switch style {
            case .presentModally:
                viewController.modalPresentationStyle = .formSheet
                navigationController.present(viewController, animated: animated)
            case .presentFullscreen:
                viewController.modalPresentationStyle = .fullScreen
                navigationController.present(viewController, animated: animated)
            case .popToView:
                navigationController.viewControllers = [viewController]
            case .def:
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true, complition: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: true) {
            complition()
        }
    }
}

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal // This helps for hide back button title
    }
    
    public func setNav() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.setBackColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundEffect = nil
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.tintColor = UIColor.colorWithHexString("#FFFFFF")
        navigationBar.backItem?.leftBarButtonItem = .none
    }
}

extension UIColor {
    static var setBackColor: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
            UIColor.colorWithHexString("#1C1F26") :
            UIColor.colorWithHexString("#022B23")
        }
    }
}
