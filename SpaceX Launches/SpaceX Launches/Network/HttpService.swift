//
//  HttpService.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 13/03/22.
//

import Foundation

class HttpService: NSObject {
    
    func doGet<T: Decodable>(url: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        completion(.failure(.invalidResponseStatus))
                        return
                    }

            guard error == nil else {
                completion(.failure(.dataTaskError(error!.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.corruptData))
                return
            }

            let decoder = JSONDecoder()

            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Error")
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }.resume()
    }
    
    private func handleError(error: Error, statusCode: Int) -> APIError {
        print("Error \(error.localizedDescription)")
        switch statusCode {
            case 300...499:
                return APIError.HTTPError(statusCode: statusCode)
            case 500...599:
                return APIError.serverError(message: error.localizedDescription)
            default:
                return APIError.noInternet
        }
    }
    
}
