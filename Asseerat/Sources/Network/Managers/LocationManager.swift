//
//  LocationManager.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 08/12/25.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0

    private var locationCompletion: ((CLLocationCoordinate2D) -> Void)?

    var onPermissionAllowed: (() -> Void)?
    var onPermissionDenied: (() -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    // MARK: - PUBLIC METHODS

    /// Modern permission check
    func isLocationAllowed() -> Bool {
        let status = manager.authorizationStatus
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }

    /// Get exact authorization status
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return manager.authorizationStatus
    }

    /// Get current location or wait for update
    func getLocation(completion: @escaping (CLLocationCoordinate2D) -> Void) {

        // Check permission
        guard isLocationAllowed() else {
            print("Location permission denied")
            return
        }

        // If we already have location → return immediately
        if latitude != 0.0 && longitude != 0.0 {
            completion(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            return
        }

        // Otherwise wait for next update
        print("Waiting for location update…")
        locationCompletion = completion
    }

    // MARK: - DELEGATES
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        print("Authorization changed:", status.rawValue)

        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            onPermissionAllowed?()
            manager.startUpdatingLocation()
        case .denied, .restricted:
            onPermissionDenied?()
        case .notDetermined:
            print("Location not determined yet")
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude

        if let completion = locationCompletion {
            completion(location.coordinate)
            locationCompletion = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    func distanceInKM(latStart: Double, lonStart: Double, latEnd: Double, lonEnd: Double) -> Double {
        let locationA = CLLocation(latitude: latStart, longitude: lonStart)
        let locationB = CLLocation(latitude: latEnd, longitude: lonEnd)
        
        let distanceMeters = locationA.distance(from: locationB)   // meters
        let distanceKM = distanceMeters / 1000.0                   // convert to km
        
        return distanceKM
    }
}
