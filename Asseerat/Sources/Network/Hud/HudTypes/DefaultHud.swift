//
//  DefaultHud.swift
//  MKBNetworkRxSwift
//
//  Created by 1 on 9/2/20.
//  Copyright © 2020 loremispum. All rights reserved.
//

import UIKit
import MBProgressHUD
import Lottie

public protocol DefaultHud {
    var defaultHud:MBProgressHUD{get}
    func showDefaultHud(view: UIView?, hud: MBProgressHUD)
    func hideDefaultHud(hud: MBProgressHUD)
}

extension DefaultHud {
    public func showDefaultHud(view: UIView?, hud: MBProgressHUD) {
        if let backView = view{
            backView.addSubview(hud)
        }else{
            //let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let keyWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first(where: { $0.activationState == .foregroundActive })?
                .windows
                .filter { $0.isKeyWindow }
                .first

            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }

            // topController should now be your topmost view controller
                topController.view.addSubview(hud)
            }
        }
        (hud.customView as! NVActivityIndicatorView).startAnimating()
        hud.show(animated: true)
    }
    public func hideDefaultHud(hud:MBProgressHUD){
        (hud.customView as! NVActivityIndicatorView).stopAnimating()
        hud.hide(animated: true)
        hud.removeFromSuperview()
    }
}
public protocol DownloadHud {
    var downloadHud:MBProgressHUD{get}
    func showDefaultHud(view:UIView?,hud:MBProgressHUD)
    func hideDefaultHud(hud:MBProgressHUD)
}
extension DownloadHud{
    func showDefaultHud(view:UIView?,hud:MBProgressHUD){
       if let backView = view{
           backView.addSubview(hud)
       }else{
           //let window = UIApplication.shared.windows.last
           let window = UIApplication.shared.connectedScenes
               .compactMap { $0 as? UIWindowScene }
               .first(where: { $0.activationState == .foregroundActive })?
               .windows
               .last
           window?.addSubview(hud)
       }
       hud.show(animated: true)
   }
    func hideDefaultHud(hud:MBProgressHUD){
       hud.hide(animated: true)
       
   }
}
public protocol LottieLoader {
    var defaultHud:MBProgressHUD { get }
    func showDefaultHud(view: UIView?, hud: MBProgressHUD)
    func hideDefaultHud(hud: MBProgressHUD)
}

extension LottieLoader{
    public func showDefaultHud(view: UIView?, hud: MBProgressHUD){
        if let backView = view{
            backView.addSubview(hud)
        }else{
            //let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let keyWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first(where: { $0.activationState == .foregroundActive })?
                .windows
                .filter { $0.isKeyWindow }
                .first

            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.view.addSubview(hud)
            }
        }
       // (hud.customView as! LottieAnimationView).play()
        hud.show(animated: true)
    }
    public func hideDefaultHud(hud: MBProgressHUD){
        hud.hide(animated: true)
      //  (hud.customView as! LottieAnimationView).stop()
        hud.removeFromSuperview()
    }
}
