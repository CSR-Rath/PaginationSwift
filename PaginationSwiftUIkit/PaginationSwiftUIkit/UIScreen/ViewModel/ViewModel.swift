//
//  ViewModel.swift
//  PaginationSwiftUIkit
//
//  Created by Rath! on 14/6/24.
//

import Foundation


class ViewModel{
    
    static func getDataApi(page: Int, size: Int, succes: @escaping (Model) -> Void){
        
        ApiManager.shared.apiConnection(url: "https://pokeapi.co/api/v2/pokemon?limit=\(size)&offset=\(page)",
                                        method: .GET,
                                        param: nil,
                                        headers: nil) { (data: Model) in
            
            succes(data)
        }
    }
}
