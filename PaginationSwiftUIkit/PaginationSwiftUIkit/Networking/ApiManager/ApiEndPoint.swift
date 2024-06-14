//
//  ApiEndPoint.swift
//  EnvironmentDemo
//
//  Created by Rath! on 6/6/24.
//

import Foundation

enum ApiEndPoint: String {
    case baseUrl = "https://jsonplaceholder.typicode.com"
    case getUsers = "/users"
    
    static let mainUrl  = "http://uat-api-prime.combomkt.com"
    static let keyEncrypt = "c2njfUy9wnBcm3onyI4eaQzW3h82s8ma"
    static let vecEncrypt = "2cK2v84kLo3LeWr2"
}

//let v =  ApiEndPoint.baseUrl
