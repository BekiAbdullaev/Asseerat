//
//  HudMaker.swift
//  MKBNetworkRxSwift
//
//  Created by 1 on 9/2/20.
//  Copyright © 2020 loremispum. All rights reserved.
//
import MBProgressHUD
import Lottie

public enum HudTypes{
    case defaultHud
    case customHud
    case downloadHud
}

public struct HudMaker {
    public init(){}
    
    public func makeHud(type: HudTypes) -> MBProgressHUD {
        switch type {
        case .customHud:
            return createCustomLottieLoader()
        case .downloadHud:
            return createDownloadHud()
        default:
            return createDefaultHud()
        }
    }
    
    public func createDefaultHud()->MBProgressHUD {
        let hud = MBProgressHUD()
        hud.animationType = .zoomOut
        hud.mode = .customView
        hud.customView = NVActivityIndicatorView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 37,
                height: 37),
            type: .circleStrokeSpin,
            color: .black,
            padding: nil)
        
        hud.bezelView.color = .clear
//        hud.bezelView.style = .solidColor
//        hud.backgroundView.style = .blur
//        hud.backgroundView.blurEffectStyle = .regular
        hud.tag = 1234
        return hud
    }
    
    public func createDownloadHud() -> MBProgressHUD {
        let hud = MBProgressHUD()
        hud.animationType = .zoomOut
        hud.mode = .indeterminate
        hud.label.text = "Загрузка..."
//        hud.progressObject
        hud.bezelView.color = .clear
//        hud.bezelView.style = .solidColor
//        hud.backgroundView.style = .blur
//        hud.backgroundView.blurEffectStyle = .regular
        return hud
    }
    public func createCustomLottieLoader()-> MBProgressHUD{
        let hud = MBProgressHUD()
        hud.mode = .customView
        let animationView = LottieAnimationView(animation: CBAnimation.loader.getAnimation())
        animationView.loopMode = .playOnce
        hud.customView = animationView
        hud.bezelView.color = .clear
        hud.bezelView.style = .solidColor
        hud.backgroundView.style = .blur
        hud.backgroundView.blurEffectStyle = .regular
        return hud
    }
}

enum CBAnimation:String {
    case loader = "loader"

    func getAnimation() -> LottieAnimation {
        return LottieAnimation.named(self.rawValue, bundle: .main)!
    }
}
