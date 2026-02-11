//
//  File.swift
//  
//
//  Created by Bekzod Abdullaev on 10/17/22.
//

import Foundation
import Moya
import MBProgressHUD

public final class RequestLoadingPlugin: PluginType, LottieLoader {
    public let defaultHud = HudMaker().makeHud(type: .downloadHud)
    
    public func willSend(_ request: RequestType, target: TargetType) {
        // show loading
        DispatchQueue.main.async {
            self.showDefaultHud(view: nil, hud: self.defaultHud)
        }
    }
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        // hide loading
        DispatchQueue.main.async {
            self.hideDefaultHud(hud: self.defaultHud)
        }
    }
}
