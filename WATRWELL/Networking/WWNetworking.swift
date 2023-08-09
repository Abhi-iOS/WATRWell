//
//  WWNetworking.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/08/23.
//

import Foundation
import UIKit
import RxSwift
import NVActivityIndicatorView

typealias APIResponse = (Result<JSON,NSError>) -> ()

enum AppNetworking {
    
    static var timeOutInterval = TimeInterval(90)
    static let dispose = DisposeBag()
    
    @discardableResult
    private static func executeRequest(_ request: NSMutableURLRequest, _ result: @escaping APIResponse) -> URLSession {
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = timeOutInterval
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if (error == nil) {
                do {
                    if let jsonData = data {
                        if var jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                            print("Response: ======= \n")
                            if let response = response as? HTTPURLResponse {
                                jsonDataDict["auth"] = response.allHeaderFields["Authorization"]
                            }
                            print(jsonDataDict)
                            DispatchQueue.main.async(execute: { () -> Void in
                                result(.success(JSON(jsonDataDict)))
                            })
                        }
                        
                    }else{
                        let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No Data Found".uppercased()])
                        result(.failure(error))
                    }
                } catch let err as NSError {
                    let responseString = String(data: data!, encoding: .utf8)
                    print("responseString = \(responseString ?? "")")
                    DispatchQueue.main.async(execute: { () -> Void in
                        result(.failure(err))
                    })
                }
            } else {
                if let err = error {
                    DispatchQueue.main.async(execute: { () -> Void in
                        //MARK:- Handle No Internet
                        if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                            SKToast.show(withMessage: "No Internet connection".uppercased())
                            AppNetworking.showNoInternetConnectionWindow(request,result)
                            
                        }else{
                            result(.failure(err as NSError))
                        }
                    })
                }else{
                    let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected Error encountered".uppercased()])
                    result(.failure(error))
                }
            }
        })
        
        dataTask.resume()
        return session
    }
    
    @discardableResult
    fileprivate static func checkRefereshTokenAndExecute(_ request: NSMutableURLRequest, _ loader: Bool, response : @escaping APIResponse) -> URLSession {
        return executeRequest(request) { (result) in
            if loader { hideLoader() }
            switch result{
            case .success(let json) :
                let message = json["message"].stringValue
                var apiCode: WWApiCode = .success
                
                if let code = WWApiCode(rawValue: json["statusCode"].intValue){
                    apiCode = code
                } else if let code = WWApiCode(rawValue: json["meta"]["status"].intValue){
                    apiCode = code
                } else if let code = WWApiCode(rawValue: json["cod"].intValue){
                    apiCode = code
                }
                
                switch apiCode {
                case .unauthorized:
                    WWRouter.shared.setLandingScene()
                    SKToast.show(withMessage: message)
                case .success:
                    response(.success(json))
                case .badRequest, .undetermined:
                    SKToast.show(withMessage: message)
                    response(.failure(NSError(localizedDescription: message)))
                default:
                    response(.success(json))
                }
                
            case .failure(let error) :
                SKToast.show(withMessage: error.localizedDescription)
                response(.failure(error))
            }
        }
    }
    
    @discardableResult
    private static func REQUEST(withUrl url : URL?,method : String,postData : Data?,header : [String:String],loader : Bool, response : @escaping APIResponse) -> URLSession? {
        
        guard let url = url else {
            let error = NSError(localizedDescription: "Url or parameters not valid")
            response(.failure(error))
            return nil
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = method
                
        var updatedHeaders = header
        
        if let token = WWUserDefaults.value(forKey: .userAuth).string, !token.isEmpty {
            updatedHeaders["Authorization"] = "Bearer \(token)"
        }
        
        print("============ \n Headers are =======> \n\n \(updatedHeaders) \n =================")
        print("============ \n Url is =======> \n\n \(url.absoluteString) \n =================")

        request.allHTTPHeaderFields = updatedHeaders
        
        request.httpBody = postData
        if loader { AppNetworking.showLoader() }
        
        return checkRefereshTokenAndExecute(request, loader, response: response)
    }
    
    @discardableResult
    static func GET(endPoint : String,
                    parameters : [String : Any] = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    response : @escaping APIResponse) -> URLSession? {
        
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{
            return nil
        }
        
        let uri = URL(string: urlString)
        
        return REQUEST(withUrl: uri,
                       method: "GET",
                       postData : nil,
                       header: headers,
                       loader: loader,
                       response: response)
        
    }
    
    static func POST(endPoint : String,
                     parameters : [String : Any] = [:],
                     headers : HTTPHeaders = [:],
                     loader : Bool = true,
                     response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        
        REQUEST(withUrl: uri,
                method: "POST",
                postData : postData,
                header: headers,
                loader: loader,
                response: response)
        
    }
    
    static func PATCH(endPoint : String,
                      parameters : [String : Any] = [:],
                      headers : HTTPHeaders = [:],
                      loader : Bool = true,
                      response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        let uri = URL(string: urlString)
        
        REQUEST(withUrl: uri,
                method: "PATCH",
                postData : nil,
                header: headers,
                loader: loader,
                response: response)
        
    }
    
    static func POSTWithRawJSON(endPoint : String,
                                parameters : [String : Any] = [:],
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "application/json"
        REQUEST(withUrl: uri,
                method: "POST",
                postData : postData,
                header: updatedHeader,
                loader: loader,
                response: response)
        
    }
    
    
    static func POSTWithImage(endPoint : String,
                              parameters : [String : Any] = [:],
                              image : [String : UIImage] = [:],
                              headers : HTTPHeaders = [:],
                              loader : Bool = true,
                              response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let boundary = generateBoundary()
        let postData = createDataBody(withParameters: parameters, media: image, boundary: boundary)
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        
        REQUEST(withUrl: uri,
                method: "POST",
                postData : postData,
                header: updatedHeader,
                loader: loader,
                response: response)
        
    }
    static func PUT(endPoint : String,
                    parameters : [String : Any] = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        
        REQUEST(withUrl: uri,
                method: "PUT",
                postData : postData,
                header: headers,
                loader: loader,
                response: response)
        
    }
    
    static func PUTWithRawJSON(endPoint : String,
                               parameters : [String : Any] = [:],
                               headers : HTTPHeaders = [:],
                               loader : Bool = true,
                               response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "application/json"
        
        REQUEST(withUrl: uri,
                method: "PUT",
                postData : postData,
                header: updatedHeader,
                loader: loader,
                response: response)
        
    }
    
    static func PATCHWithRawJSON(endPoint : String,
                                 parameters : [String : Any] = [:],
                                 headers : HTTPHeaders = [:],
                                 loader : Bool = true,
                                 response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        var updatedHeader = headers
        
        updatedHeader["Content-Type"] = "application/json"
        
        REQUEST(withUrl: uri,
                method: "PATCH",
                postData : postData,
                header: updatedHeader,
                loader: loader,
                response: response)
        
    }
    
    static func DELETE(endPoint : String,
                       parameters : [String : Any] = [:],
                       headers : HTTPHeaders = [:],
                       loader : Bool = true,
                       response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        guard let urlString = (endPoint + "?" + encodeParamaters(params: parameters)).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else{
            return
        }
        
        let uri = URL(string: urlString)
        
        REQUEST(withUrl: uri,
                method: "DELETE",
                postData : nil,
                header: headers,
                loader: loader,
                response: response)
        
    }
    
    static func DeleteWithRawJson(endPoint : String,
                                  parameters : [String : Any] = [:],
                                  headers : HTTPHeaders = [:],
                                  loader : Bool = true,
                                  response : @escaping APIResponse) {
        
        print("============ \n Parameters are =======> \n\n \(parameters) \n =================")
        
        let uri = URL(string: endPoint)
        
        let postData = encodeParamaters(params: parameters).data(using: String.Encoding.utf8)
        
        var header = headers
        header["content-type"] = "application/x-www-form-urlencoded"
        
        REQUEST(withUrl: uri,
                method: "DELETE",
                postData : postData,
                header: header,
                loader: loader,
                response: response)
    }
    
    static private func encodeParamaters(params : [String : Any]) -> String {
        
        var result = ""
        
        for key in params.keys {
            
            result.append(key+"=\(params[key] ?? "")&")
            
        }
        
        if !result.isEmpty {
            result.remove(at: result.index(before: result.endIndex))
        }
        
        return result
    }
    
    static func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    static func createDataBody(withParameters params: [String:Any]?, media: [String:UIImage]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media.keys {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo)\"; filename=\" image.jpg\"\(lineBreak)")
                body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
                
                let data = media[photo]!.jpegData(compressionQuality: 0.7)
                body.append(data!)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}

extension AppNetworking {
    
    static func showLoader() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballBeat
        NVActivityIndicatorView.DEFAULT_COLOR = WWColors.hexDF5509.color
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    static func hideLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}



extension Data {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension AppNetworking {
    
    private static var basicAuth : String{
        let username = "pet"
        let password = "social"
        
        let authString = String(format: "%@:%@", username, password)
        let authData = authString.data(using: String.Encoding.utf8)!
        return "Basic " + authData.base64EncodedString()
    }
}

//MARK:- Handle No Internet Connection
extension AppNetworking{
    static func showNoInternetConnectionWindow(_ request: NSMutableURLRequest, _ result: @escaping APIResponse){
        AppNetworking.hideLoader()
        SKToast.show(withMessage: "No Internet Connection".uppercased())
        
    }
    
}

enum WWApiCode : Int {
    case success = 200
    case resourceCreated = 201
    case unauthorized = 401
    case badRequest = 400
    case undetermined = -224
    case actionDeclined = 422
    case resourceDeleted = 204
}

enum WWAPIErrorCode: Int{
    case notAllowed = 4220
    case resourceDeleted = 422
}
