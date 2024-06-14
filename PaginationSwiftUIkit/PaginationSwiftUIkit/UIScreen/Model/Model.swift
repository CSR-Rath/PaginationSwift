//
//  Model.swift
//  PaginationSwiftUIkit
//
//  Created by Rath! on 14/6/24.
//

import Foundation


struct Model : Codable{
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
    
}

struct Result: Codable{
    let name: String?
    let url: String?
}
