//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 02/06/25.
//

import Foundation
import MBProgressHUD
import Moya

public typealias NetworkFailureBlock = ((ErrorResponse?) -> ())

public enum Config {
    case noHudAuthorized
    case noHud
    case defaultConfig
    case authorized
}

extension NetworkManager{
    public struct NetworkConfiguration {
        public var baseURL: APIBase
        public init(baseURL:APIBase){
            self.baseURL = baseURL
        }
    }
}

public class NetworkManager{
    
    // MARK: - Properties
    #if DEBUG
    var plugins = [NetworkPlugins.Logger.plugin]
    #else
    var plugins = [PluginType]()
    #endif
    
    var provider: MoyaProvider<MultiTarget>?
    public var configuration: NetworkConfiguration

    public init(hudType type:Config = .authorized, configuration: NetworkConfiguration = NetworkConfiguration(baseURL: APIBase.production)) {
        switch type {
        case .noHudAuthorized:
            provider = MoyaProvider<MultiTarget>(plugins:plugins)
        case .noHud:
            provider = MoyaProvider<MultiTarget>(plugins:plugins)
        case .defaultConfig:
            plugins.append(NetworkPlugins.Hud.plugin)
            provider = MoyaProvider<MultiTarget>(plugins:plugins)
        case .authorized:
            plugins.append(NetworkPlugins.Authorized.plugin)
            provider = MoyaProvider<MultiTarget>(plugins:plugins)
        }
        self.configuration = configuration
    }
    
    // MARK: Generic method for sendinig any targetype
    public func request<R: TargetType, T>(_ target: R, success: ((T) -> ())?, emptySuccess:(() -> ())? = {}, failure: NetworkFailureBlock?)  where T: Codable {
        provider!.request(MultiTarget(target), completion: { result in
            switch result {
            case let .success(response):
                
                if response.statusCode != 204 /*&& response.statusCode != 201*/ {
                    self.processResponse(result: result, success: success, failure: failure)
                } else {
                    self.processWithoutMapResponse(result: result, success: emptySuccess, failure: failure)
                }
            case let .failure(error):
                print(error)
            }
            
        })
    }
    
    public func downloadFile<R: TargetType>(_ target: R, completion: @escaping (Data?) -> Void) {
        guard let provider = provider else {
            print("Network provider is not initialized.")
            completion(nil)
            return
        }
        
        provider.request(MultiTarget(target)) { result in
            switch result {
            case let .success(response):
                self.validate(response, success: {
                    completion(response.data)
                }, error: { error in
                    completion(nil)
                })
                
            case let .failure(error):
                print("Network request failed: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    public func processResponse<T>(result: Result<Moya.Response, MoyaError>, success: ((T) -> ())?, failure: NetworkFailureBlock?) where T: Codable {
        switch result {
        case let .success(response):
            self.validate(response, success: { () in
                do {
                    
                    
                    let data = try response.map(T.self)
                    success?(data)
                    
                    
                    
                } catch let error {
                    print("Cannot map \(error)")
                }
            }, error: { (error) in
                
                failure?(ErrorResponse(reason: error?.reason, statusCode: error?.code, code: 0, devMessage: error?.devMessage))
            })
        case let .failure(error):
            print(error)
            failure?(ErrorResponse(reason: error.localizedDescription, statusCode: error.errorCode, code: 0, devMessage: ""))
        }
    }
    
    public func processWithoutMapResponse(result: Result<Moya.Response,MoyaError>, success:(()->())?,failure:NetworkFailureBlock?){
        
        switch result {
        case let .success(response):
            self.validate(response) {
                success?()
            } error: { (error) in
                failure?(error)
            }
        case let .failure(error):
            print(error)
        }
    }
    
    public func validate(_ response: Response, success: @escaping (() -> ()), error: @escaping ((ErrorResponse?) -> ())) {
        
        _ = Data()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
      
        if (response.statusCode >= 200) && (response.statusCode < 300) {
            success()
        }
        //TODO: - Implement error cases
        else if ((response.statusCode == 400) || (response.statusCode == 403)) {
            
            var presentableError: ErrorResponse? = nil
            do {
                let errorResponse = try response.map(DefaultResponse.self)
                presentableError = ErrorResponse(reason: errorResponse.msg, statusCode: response.statusCode, code: errorResponse.code, devMessage: "")
            }
            catch {
                print(error)
            }
            error(presentableError)
        } else if (response.statusCode == 406 || response.statusCode == 401) {
            // MARK: - Token expired case
            
            var presentableError: ErrorResponse? = nil
            do {
                let errorResponse = try response.map(DefaultResponse.self)
                presentableError = ErrorResponse(reason: errorResponse.msg, statusCode: errorResponse.code, code: errorResponse.code, devMessage: "")
            } catch {
                print("error with message: \(String(describing: presentableError?.reason)) and status code:\(String(describing: presentableError?.code))")
            }
            error(presentableError)
        } else {
            var presentableError: ErrorResponse? = nil
            do {
                let errorResponse = try response.map(DefaultResponse.self)
                presentableError = ErrorResponse(reason: errorResponse.msg, statusCode: errorResponse.code, code: errorResponse.code, devMessage: "")
            } catch {
                print(error)
            }
            error(presentableError)
        }
    }
}
