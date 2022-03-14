//
//  BaseAPI.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 13/03/22.
//

import Foundation

class BaseAPI: NSObject {
    
    static let shared: BaseAPI = {
        return BaseAPI()
    }()
    
    private(set) var baseURL = Constants.baseURL
}

