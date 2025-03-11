//  Zoetis -Feathers
//
//  Created by "" ""on 08/11/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessBlock = (JSON) -> Void
typealias ErrorBlock = (NSError) -> Void
let apiHeaders = ["DeviceType":"ios", "UserId":"\(String(describing: UserDefaults.standard.value(forKey: "Id") ?? 0))",
                  "Authorization":"\(AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype") ?? "")"]

extension Notification.Name {
    
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum ZoetisApiManager {
    
    static func POST(showHud: Bool,
                     showHudText: String,
                     endPoint: String,
                     parameters: JSONDictionary = [:],
                     imageData: Data = Data(),
                     imageKey: String = "",
                     headers: JSONDictionary = [:],
                     success : @escaping SuccessBlock,
                     failure : @escaping ErrorBlock) {
        
        request(showHud: showHud, showHudText: showHudText, URLString: endPoint, httpMethod: .post, parameters: parameters, imageData: imageData,
                imageKey: imageKey, headers: apiHeaders, success: success, failure: failure)
    }
    
    static func GET(showHud: Bool,
                    showHudText: String,
                    endPoint: String,
                    parameters: JSONDictionary = [:],
                    headers: JSONDictionary = [:],
                    success : @escaping SuccessBlock,
                    failure : @escaping ErrorBlock) {
        
        request(showHud: showHud, showHudText: showHudText, URLString: endPoint, httpMethod: .get, parameters: parameters, headers: apiHeaders, success: success, failure: failure)
    }
    
    static func PUT(showHud: Bool,
                    showHudText: String,
                    endPoint: String,
                    parameters: JSONDictionary = [:],
                    imageData: Data = Data(),
                    imageKey: String = "",
                    headers: JSONDictionary = [:],
                    success : @escaping SuccessBlock,
                    failure : @escaping ErrorBlock) {
        
        request(showHud: showHud, showHudText: showHudText, URLString: endPoint, httpMethod: .put, parameters: parameters, imageData: imageData,
                imageKey: imageKey, headers: apiHeaders, success: success, failure: failure)
    }
    
    static func PATCH(showHud: Bool,
                      showHudText: String,
                      endPoint: String,
                      parameters: JSONDictionary = [:],
                      imageData: Data = Data(),
                      imageKey: String = "",
                      headers: JSONDictionary = [:],
                      success : @escaping SuccessBlock,
                      failure : @escaping ErrorBlock) {
        
        request(showHud: showHud, showHudText: showHudText, URLString: endPoint, httpMethod: .patch, parameters: parameters, imageData: imageData,
                imageKey: imageKey, headers: apiHeaders, success: success, failure: failure)
    }
    
    static func DELETE(showHud: Bool,
                       showHudText: String,
                       endPoint: String,
                       parameters: JSONDictionary = [:],
                       headers: JSONDictionary = [:],
                       success : @escaping SuccessBlock,
                       failure : @escaping ErrorBlock) {
        
        request(showHud: showHud, showHudText: showHudText, URLString: endPoint, httpMethod: .delete, parameters: parameters, headers: apiHeaders, success: success, failure: failure)
    }
    
    private static func request(showHud: Bool,
                                showHudText: String,
                                URLString: String,
                                httpMethod: HTTPMethod,
                                parameters: JSONDictionary = [:],
                                imageData: Data = Data(),
                                imageKey: String = "",
                                headers: JSONDictionary = [:],
                                success : @escaping SuccessBlock,
                                failure : @escaping ErrorBlock) {
        
        var additionalHeaders: HTTPHeaders?
        additionalHeaders = ["DeviceType":"ios", "UserId":"\(String(describing: UserDefaults.standard.value(forKey: "Id") ?? 0))",
                             "Authorization":"\(AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype") ?? "")"]
        
        if imageKey != "" {
            // guard let URL = try? URLRequest(url: URLString, method: httpMethod, headers: additionalHeaders) else {return}
            guard let url = URL(string: URLString) else {
                //completion(nil, nil)
                return
            }
            AF.upload(
                multipartFormData: { multipartFormData in
                    for (key, value) in parameters {
                        if let data = "\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                    multipartFormData.append(imageData, withName: imageKey, fileName: "image.png", mimeType: "jpeg/png")             },
                to: url, method: .post, headers: additionalHeaders )
            .responseJSON { resp in
                switch resp.result {
                case .success(let value):
                    //value.responseJSON { (value: AFDataResponse<Data>) in
                    parseResponse(value as! AFDataResponse<Data>, success: success, failure: failure)
                    //}
                case .failure(let error):
                    print(error)
                    failure(error as NSError)
                }
                
            }
            
        } else {
            print("*************\(URLString)***************")
            
            AF.request(URLString, method: httpMethod,
                       parameters: parameters,
                       encoding: httpMethod == .post || httpMethod == .put || httpMethod == .patch ? JSONEncoding.default : URLEncoding.queryString,
                       headers: additionalHeaders).responseData { (response: AFDataResponse<Data>) in
                print("Response from server is ",response)
                parseResponse(response, success: success, failure: failure)
            }
        }
        
    }
    
    
    private static func parseResponse(_ response: AFDataResponse<Data>,
                                      success : @escaping SuccessBlock,
                                      failure : @escaping ErrorBlock) {
        switch response.result {
        case .success(let value): success(JSON(value))
        case .failure(let error):
            let err = (error as NSError)
            if err.code == NSURLErrorNotConnectedToInternet || err.code == NSURLErrorInternationalRoamingOff {
                // Handle Internet Not available UI
                NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                
                let internetNotAvailableError = err
                failure(internetNotAvailableError)
            } else {
                failure(error as NSError)
            }
        }
    }
}
