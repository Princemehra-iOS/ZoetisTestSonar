//
//  WebClass.swift
//  Zoetis -Feathers
//
//  Created by "" on 14/09/16.
//  Copyright © 2016 "". All rights reserved.
// 

import UIKit
import ReachabilitySwift
import SystemConfiguration

class WebClass: NSObject {

        static let sharedInstance = WebClass()
        let webUrl = "https://mypoultryview360.com/HealthManagementSystemAPIV1_1/api/"
  
 
     func connected() -> Bool
      {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
