//
//  ProfileEditViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 18/09/25.
//

import Foundation
import PhotosUI

class ProfileEditViewModel: ObservableObject {
    
    
    func openSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(
                    settingsUrl,
                    options: [:],
                    completionHandler: nil
                )
            }
        }
    }
    
    func isCameraPermissionEnabled() -> Bool {
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)

        switch cameraStatus {
        case .authorized:
            // Permission granted
            print("Camera access granted")
            return true
        case .denied, .restricted:
            // Permission denied or restricted
            print("Camera access denied/restricted")
            return false

        case .notDetermined:
            // Request permission
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        print("Camera access granted after request")
                    } else {
                        print("Camera access denied after request")
                    }
                }
            }
            return false
        @unknown default:
            // Handle unexpected cases
            print("Unknown camera authorization status")
            return false
        }
    }
    

    func editUserInfo(reqBody:ProfileEditModel.Request.EditUserInfo, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(OtherAPI.editUserInfo(body: reqBody)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    
    func deleteUserAccount(onComplete:@escaping(()->())) {
        let userId = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(OtherAPI.deleteAccount(userId: userId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
