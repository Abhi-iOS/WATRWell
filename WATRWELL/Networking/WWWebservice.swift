//
//  WWWebservice.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 02/08/23.
//

import Foundation
enum WebServices { }

extension NSError {
    
    convenience init(localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String, userInfo: [String: Any]?) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription, NSLocalizedRecoverySuggestionErrorKey : userInfo as Any])
    }
}


extension WebServices {
    
    // MARK:- Common POST API
    static func commonPostAPI(parameters: JSONDictionary,
                              endPoint: EndPoint,
                              loader: Bool = true,
                              response : @escaping APIResponse) {
        
        AppNetworking.POST(endPoint: endPoint.path, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json["info"].dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    //MARK: - Common PATCH API
    static func commonPatchAPI(parameters: JSONDictionary,
                              endPoint: EndPoint,
                              toAppend : String = "",
                              loader: Bool = true,
                              response : @escaping APIResponse) {
        let path = toAppend.isEmpty ? endPoint.path : endPoint.path + "/\(toAppend)"
        AppNetworking.PATCH(endPoint: path, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(localizedDescription: json["message"].string ?? "Something went wrong")
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    // MARK:- Common POST API with raw JSON
    static func commonPostWithRawJSONAPI(parameters: JSONDictionary,
                                         endPoint: EndPoint,
                                         toAppend: String = "",
                                         loader: Bool = true,
                                         response : @escaping APIResponse) {
        
        let path = toAppend.isEmpty ? endPoint.path : endPoint.path + "/\(toAppend)"

        AppNetworking.POSTWithRawJSON(endPoint: path, parameters: parameters, loader: loader) { (result) in
            switch result {
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success, .resourceCreated:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json["info"].dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    // MARK:- Common GET API
    @discardableResult
    static func commonGetAPI(parameters: JSONDictionary,
                             endPoint: EndPoint,
                             toAppend : String = "",
                             loader: Bool = true,
                             response : @escaping APIResponse) -> URLSession? {
        let path = toAppend.isEmpty ? endPoint.path : endPoint.path + "/\(toAppend)"
        return AppNetworking.GET(endPoint: path, parameters: parameters, loader: loader) { (result) in
            switch result {
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json.dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    // MARK:- Common DELETE API
    static func commonDeleteAPI(parameters: JSONDictionary,
                                endPoint: EndPoint,
                                toAppend : String = "",
                                loader: Bool = true,
                                response : @escaping APIResponse) {
        let path = toAppend.isEmpty ? endPoint.path : endPoint.path + "/\(toAppend)"
        AppNetworking.DELETE(endPoint: path, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    response(.failure(NSError(localizedDescription: json["message"].string ?? "Something went wrong")))
                }
            case .failure(let error): response(.failure(error))
            }
        }
    }
    
    // MARK:- Common Delete API with Append on URL
    static func commonDeleteAPIWithAppendinURL(parameters: JSONDictionary,
                                               endPoint: EndPoint,
                                               append:String,
                                               loader: Bool = true,
                                               response : @escaping APIResponse) {
        
        let endPoint = endPoint.path+"/"+append
        
        AppNetworking.DELETE(endPoint: endPoint, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json.dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    
    //MARK:- Common Post API with Appending URL
    static func commonPostAPIWithAppendingURL(parameters: JSONDictionary,
                                              endPoint: EndPoint,
                                              append:String,
                                              loader: Bool = true,
                                              response : @escaping APIResponse) {
        
        
        let endPoint = endPoint.path+"/"+append
        AppNetworking.POST(endPoint: endPoint, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json.dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    //MARK:- Common Get API with Appending URL
    @discardableResult
    static func commonGetAPIWithAppendingURL(parameters: JSONDictionary,
                                              endPoint: EndPoint,
                                              append:String,
                                              loader: Bool = true,
                                              response : @escaping APIResponse) -> URLSession? {
        
        let endPoint = endPoint.path+"/"+append
        return AppNetworking.GET(endPoint: endPoint, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json.dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    // MARK:- Common POST API
    static func commonDeleteRawJsonAPI(parameters: JSONDictionary,
                                       endPoint: EndPoint,
                                       loader: Bool = true,
                                       response : @escaping APIResponse) {
        
        AppNetworking.DeleteWithRawJson(endPoint: endPoint.path, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json.dictionaryObject)
                    response(.failure(error))
                }
            case .failure(let error): response(.failure(error))
            }
        }
    }
    
    // MARK:- Common PATCH API with raw JSON
    static func commonPatchWithRawJSONAPI(parameters: JSONDictionary,
                                          endPoint: EndPoint,
                                          toAppend : String = "",
                                          loader: Bool = true,
                                          response : @escaping APIResponse) {
        
        let path = toAppend.isEmpty ? endPoint.path : endPoint.path + "/\(toAppend)"
        AppNetworking.PATCHWithRawJSON(endPoint: path, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json.dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    
    // MARK:- Common PUT API with raw JSON
    static func commonPutWithRawJSONAPI(parameters: JSONDictionary,
                                        endPoint: EndPoint,
                                        toAppend : String = "",
                                        loader: Bool = true,
                                        response : @escaping APIResponse) {
        
        let path = toAppend.isEmpty ? endPoint.path : endPoint.path + "/\(toAppend)"
        AppNetworking.PUTWithRawJSON(endPoint: path, parameters: parameters, loader: loader) { (result) in
            switch result{
            case .success(let json):
                let code = WWApiCode(rawValue: json["status"].intValue) ?? .undetermined
                switch code {
                case .success:
                    response(.success(json))
                default:
                    let error = NSError(code: code.rawValue, localizedDescription: json["message"].string ?? "Something went wrong", userInfo: json.dictionaryObject)
                    response(.failure(error))
                    SKToast.show(withMessage: error.localizedDescription)
                }
            case .failure(let error):
                response(.failure(error))
                SKToast.show(withMessage: error.localizedDescription)
            }
        }
    }
}
