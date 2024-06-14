//
//  ApiManager.swift
//  EnvironmentDemo
//
//  Created by Rath! on 6/6/24.
//

import Foundation
import UIKit

class ApiManager {
    static let shared = ApiManager()
    
    // Get the default headers
    func getHeader() -> HTTPHeaders {
        let token = "" // UserDefaults.standard.string(forKey: AppConstants.token) ?? ""
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Authorize": "4ee0d884634c0b04360c5d26060eb0dac61209c0db21d84aa9b315f1599e9a41",
            "Auth": "6213cbd30b40d782b27bcaf41f354fb8aa2353a9e59c66fba790febe9ab4cf44",
            "lang": "en"
        ]
    }
    
    func apiConnection<T: Codable>(url: String, method: HTTPMethod, param: Parameters?, headers: HTTPHeaders?, res: @escaping (T) -> ()) {
        let strUrl = URL(string: url)
        let request = NSMutableURLRequest()
        request.timeoutInterval = 60
        request.url = strUrl
        request.httpMethod = method.rawValue
        
        // Check and add headers
        if headers?.isEmpty ?? true {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            if let headers = headers {
                for (headerField, headerValue) in headers {
                    request.addValue(headerValue, forHTTPHeaderField: headerField)
                }
            }
        }
        
        // Add parameters
        do {
            if let param = param {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
            }
        } catch let error as NSError {
            print("Error", error.localizedDescription)
        }
        
        let newRequest = request as URLRequest
        
        
        // Check internet
        if Reachability.isConnectedToNetwork() {
            
            // Send the request
            let task = URLSession.shared.dataTask(with: newRequest, completionHandler: { (data, response, error) in
                // Handle timeout error
                if let error = error as NSError?, error.code == NSURLErrorTimedOut {
                    DispatchQueue.main.async {
                        Loading.shared.hideLoading()
                        print("NSURLErrorTimedOut")
                    }
                    return
                }
                
                // Handle "Could not connect to the server" error
                if let error = error as NSError?, error.code == NSURLErrorCannotConnectToHost {
                    DispatchQueue.main.async {
                        Loading.shared.hideLoading()
                        print("NSURLErrorCannotConnectToHost")
                    }
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    // Handle successful response
                    if (200...299).contains(httpResponse.statusCode) {
                        // View data response Api
                        Utilize.shared.debuggerResult(urlRequest: newRequest, data: data, error: false)
                        // Validate data
                        Utilize.shared.validateModel(model: T.self, data: data) { objectData in res(objectData) }
                    }
                    // Handle 401 Unauthorized response
                    else if httpResponse.statusCode == 401 {
                        
                        print("statusCode == 401")
//                        self.refreshToken { data in
//                            let header = ["Authorization": "Bearer \(data.results?.token ?? "")"]
//                            // Call myself again
//                            self.apiConnection(url: url, method: method, param: param, headers: header, res: res)
//                        }
                    }
                    // Handle other error responses
                    else {
                        Loading.shared.hideLoading()
                        // View data response Api
                        Utilize.shared.debuggerResult(urlRequest: newRequest, data: data, error: true)
                        print("error_code: \(httpResponse.statusCode)")
                    }
                }
            })
            task.resume()
        }else{
            Loading.shared.hideLoading()
            print("Internet isn't Connected. Please check your internet.")
        }
    }
}

extension ApiManager {

    // Refresh the token
//    private func refreshToken(success: @escaping (RefreshToken) -> Void) {
//        let refreshToken = UserDefaults.standard.string(forKey: AppConstants.refreshToken) ?? ""
//        let param: [String: Any] = ["refreshToken": refreshToken]
//        let url = "http://uat-api-prime.combomkt.com/merchant/auth/refresh-token"
//        
//        apiConnection(url: url, method: .POST, param: param, headers: nil) { (data: RefreshToken) in
//            DispatchQueue.main.async {
//                if data.response?.status == 200 {
//                    UserDefaults.standard.setValue(data.results?.refreshToken, forKey: AppConstants.refreshToken)
//                    UserDefaults.standard.setValue(data.results?.token, forKey: AppConstants.token)
//                    success(data)
//                } else {
//                    Loading.shared.hideLoading()
//                    print(" ====> Refresh Error : Go to login again.")
//                }
//            }
//        }
//    }
}
