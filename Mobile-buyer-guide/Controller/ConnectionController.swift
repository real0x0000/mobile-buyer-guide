//
//  ConnectionController.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 5/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import Alamofire
import SwiftyJSON
import SystemConfiguration

class ConnectionController {
 
    static let share = ConnectionController()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
    
    func makeRequest(_ path: String, method: HTTPMethod = .get, parameters: Parameters = [:], onCompletion: @escaping (JSON?) -> Void, onError: @escaping (String) -> Void) {
        if !ConnectionController.isConnectedToNetwork() {
            onError(Properties.Message.MESSAGE_ERROR_INTERNET)
            return
        }
        Alamofire.request(path, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                if ((response.response?.statusCode)! >= 200) && ((response.response?.statusCode)! <= 299) {
                    let json = JSON(response.result.value!)
                    onCompletion(json)
                }
                else {
                    onError(Properties.Message.MESSAGE_ERROR_RESPONSE)
                }
            case .failure:
                if response.response != nil {
                    onError("\(response.response!.statusCode)")
                }
                else {
                   onError(Properties.Message.MESSAGE_ERROR_INTERNET)
                }
            }
        }
    }
    
}
