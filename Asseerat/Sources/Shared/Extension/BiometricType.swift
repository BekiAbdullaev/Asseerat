//
//  BiometricType.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/06/25.
//

import Foundation
import LocalAuthentication

public enum BiometricType {
    case none
    case touch
    case face
}

public func biometricType() -> BiometricType {
    let authContext = LAContext()
    let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    switch(authContext.biometryType) {
    case .touchID:
        return .touch
    case .faceID:
        return .face
    default:
        return .none
    }
}

