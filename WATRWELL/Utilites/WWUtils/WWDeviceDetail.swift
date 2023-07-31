//
//  WWDeviceDetail.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/08/23.
//

import UIKit

struct WWDeviceDetail {
    enum iPhoneModel {
        case Plus
        case Regular
        case X
    }
    /// Enum - NetworkTypes
    enum NetworkType: String {
        case _2G = "2G"
        case _3G = "3G"
        case _4G = "4G"
        case _5G = "5G"
        case lte = "LTE"
        case wifi = "Wifi"
        case none = ""
    }
    
    /// Device Model
    static let deviceModel : String = {
        return UIDevice.current.model
    }()
    
    /// OS Version
    static let osVersion : String = {
        return UIDevice.current.systemVersion
    }()
    
    /// Platform
    static let platform : String = {
        return UIDevice.current.systemName
    }()
    
    /// Device Id
    static let deviceId : String = {
        return UIDevice.current.identifierForVendor!.uuidString
    }()
    
    static let ipaddress : String = {
        return getWiFiAddress()
    }()

    static let model : iPhoneModel = {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.bounds.height {
            case 667:
                return .Regular
                
            case 960,1104,736:
                return .Plus
                
            case 2436,2688,1792,812,896,780,844,926:
                return .X
                
            default:
                return .Regular
            }
        }
        return .Regular
    }()
    
    private static func getWiFiAddress() -> String {
        var address : String = ""
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                
                // Check for IPv4 or IPv6 interface:
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // Check interface name:
                    if let name = String(validatingUTF8: (interface?.ifa_name)!), name == "en0" {
                        
                        // Convert interface address to a human readable string:
                        var addr = interface?.ifa_addr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(&addr!, socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
    
    static var deviceToken : String = "123456" {
        didSet{
//            updateDeviceToken()
        }
    }

    
//    private static func updateDeviceToken(){
//        guard KSUserDefaults.value(forKey: .isLoggedIn).boolValue, !KSUserDefaults.value(forKey: .isGuestUser).boolValue  else { return }
//        WebServices.updateDeviceToken()
//    }
}
