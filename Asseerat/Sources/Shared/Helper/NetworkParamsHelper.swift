//
//  NetworkParamsHelper.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 28/08/25.
//

import Foundation
import UIKit
import Reachability

public class NetworkParamsHelper {
    
    public static let shared = NetworkParamsHelper()
    private init() { }

    public func getIpAddress() -> String{
        var publicIP: String = ""
        do {
            if let url = URL(string: "https://icanhazip.com/") {
                //https://api.ipify.org/
                publicIP = try String(contentsOf: url, encoding: String.Encoding.utf8)
            }
        } catch {}
        return publicIP.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    
    public func getNetworkParams() -> NetworkParams {
        var networkState = ""
        var ipAddress = ""
        var appVersion = ""
        let connnectionType = getConnectionType()
        
        if connnectionType == .wifi {
            networkState = "wifi"
            
            if let wifiIP = getAddress(type: connnectionType) {
                ipAddress = wifiIP
            }
        } else {
            networkState = "mobileData"
            
            if let cellularIP = getAddress(type: connnectionType) {
                ipAddress = cellularIP
            }
        }
        
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            appVersion = buildNumber
        }
        
            
        return NetworkParams(
            deviceName: UIDevice.current.name,
            android_api: "ios_\(UIDevice.current.systemVersion)",
            device_type: "I",
            sim_iccd: [],
            imei_data: [],
            network_state: networkState,
            ip_address: ipAddress,
            appVersion: appVersion
        )
    }
    
    public func getConnectionType()-> ConnectionType {
        
        let reachability = try! Reachability()
        var connection:ConnectionType = .cellular
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                connection = .wifi
            } else {
                print("Reachable via Cellular")
                connection = .cellular
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        return connection
    }
    
    public func getAddress(type: ConnectionType) -> String? {
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == type.rawValue {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}

public struct NetworkParams {
    public let deviceName: String
    public let android_api: String
    public let device_type: String
    public let sim_iccd: [String]
    public let imei_data: [String]
    public let network_state: String
    public let ip_address: String
    public let appVersion:String
    
    public init(deviceName: String, android_api: String, device_type: String, sim_iccd: [String], imei_data: [String], network_state: String, ip_address: String, appVersion: String) {
        self.deviceName = deviceName
        self.android_api = android_api
        self.device_type = device_type
        self.sim_iccd = sim_iccd
        self.imei_data = imei_data
        self.network_state = network_state
        self.ip_address = ip_address
        self.appVersion = appVersion
    }
}

public struct Connection {
    public let ipAddress: String
    public let connectionType: String
}

public enum ConnectionType: String {
    case wifi = "en0"
    case cellular = "pdp_ip0"
    case ipv4 = "ipv4"
    case ipv6 = "ipv6"
}
