//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 08/11/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessBlock = (JSON) -> Void
typealias ErrorBlock = (NSError) -> Void

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
                imageKey: imageKey, headers: headers, success: success, failure: failure)
    }

    static func GET(showHud: Bool,
                    showHudText: String,
                    endPoint: String,
                    parameters: JSONDictionary = [:],
                    headers: JSONDictionary = [:],
                    success : @escaping SuccessBlock,
                    failure : @escaping ErrorBlock) {

        request(showHud: showHud, showHudText: showHudText, URLString: endPoint, httpMethod: .get, parameters: parameters, headers: headers, success: success, failure: failure)
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
                imageKey: imageKey, headers: headers, success: success, failure: failure)
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
                imageKey: imageKey, headers: headers, success: success, failure: failure)
    }

    static func DELETE(showHud: Bool,
                       showHudText: String,
                       endPoint: String,
                       parameters: JSONDictionary = [:],
                       headers: JSONDictionary = [:],
                       success : @escaping SuccessBlock,
                       failure : @escaping ErrorBlock) {

        request(showHud: showHud, showHudText: showHudText, URLString: endPoint, httpMethod: .delete, parameters: parameters, headers: headers, success: success, failure: failure)
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
        additionalHeaders = headers as? HTTPHeaders

        if imageKey != "" {
            guard let URL = try? URLRequest(url: URLString, method: httpMethod, headers: additionalHeaders) else {return}

            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                        multipartFormData.append(data, withName: key)
                    }
                }
                multipartFormData.append(imageData, withName: imageKey, fileName: "image.png", mimeType: "jpeg/png")

            }, with: URL, encodingCompletion: { (encodingResult) in
                parseEncodingResult(encodingResult, success: success, failure: failure)
            })
        } else {
                 // Alamofire.request(urlString, method: .post,parameters: parameters, headers: header).responseJSON { response in
            Alamofire.request(URLString, method: httpMethod,
                              parameters: parameters,
//                              encoding: httpMethod == .post || httpMethod == .put || httpMethod == .patch ? JSONEncoding.default : URLEncoding.queryString,
                              headers: additionalHeaders).responseJSON { (response: DataResponse<Any>) in
                                //print(response)
                                parseResponse(response, success: success, failure: failure)
            }
        }
    }

    private static func parseEncodingResult(_ result: SessionManager.MultipartFormDataEncodingResult,
                                            loader: Bool = true,
                                            success : @escaping SuccessBlock,
                                            failure : @escaping ErrorBlock) {
        switch result {
        case .success(let upload, _, _):
            upload.responseJSON { (response: DataResponse<Any>) in
                parseResponse(response, success: success, failure: failure)
            }
        case .failure(let error):
            failure(error as NSError)
        }
    }

    private static func parseResponse(_ response: DataResponse<Any>,
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
