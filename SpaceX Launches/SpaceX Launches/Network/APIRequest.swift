//
//  APIRequest.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 13/03/22.
//

protocol APIServiceProtocol {
    func getSpaceXLaunches(completion: @escaping (Result<[SpaceXLaunchModel], APIError>) -> Void)
}

class APIRequest: APIServiceProtocol {
    
    private let httpService = HttpService()
    
    // MARK: - Methods Services
    func getSpaceXLaunches(completion: @escaping (Result<[SpaceXLaunchModel], APIError>) -> Void) {
        self.httpService.doGet(url: BaseAPI.shared.baseURL) { (result: Result<[SpaceXLaunchModel], APIError>) in
            switch result {
            case .success(let launches):
                completion(.success(launches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

public enum APIError: Error {
    case noInternet
    case HTTPError(statusCode: Int)
    case serverError(message: String)
    case corruptData
    case decodingError(String)
    case dataTaskError(String)
    case invalidResponseStatus
    case invalidURL

    var description: String {
        switch self {
        case .invalidURL:
            return Constants.invalidURL
        case .noInternet:
            return Constants.noInternet
        case .HTTPError(let statusCode):
            return "\(Constants.HTTPError) \(statusCode)."
        case .serverError(let message):
            return "\(Constants.serverError) \"\(message)\"."
        case .decodingError(let string):
            return string
        case .corruptData:
            return Constants.corruptData
        case .dataTaskError(let string):
            return string
        case .invalidResponseStatus:
            return Constants.invalidResponseStatus
            
        }
    }
}


