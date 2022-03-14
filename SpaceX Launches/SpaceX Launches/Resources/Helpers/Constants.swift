//
//  Constants.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 13/03/22.
//

import Foundation
import UIKit

struct Constants {
    
    static let baseURL = "https://api.spacexdata.com/v3/launches"
    static let homeTitle = "SpaceX Lauches"
    
    //MARK: Errors
    
    static let invalidURL = "A url é inválida"
    static let noInternet = "Sem conexão de internet"
    static let HTTPError = "A chamada falhou com o códgio HTTP"
    static let serverError = "Falha no servidor:"
    static let corruptData = "Os dados providos parecem estar corrompidos"
    static let invalidResponseStatus = "A API falhou em conseguir um resposta"
    
    
}


