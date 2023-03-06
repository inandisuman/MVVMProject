//
//  NetworkManager.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noInternet
    case invalidStatusCode
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Request data from an endpoint
        /// - Parameters:
        ///   - url: the URL
        ///   - httpMethod: The HTTP Method to use, either get or post in this case
        ///   - completion: The completion closure, returning a Result of either the generic type or an error
    public func performAPICall<T: Codable>(url: URL, httpMethod: String, competion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            
            //Check if no error and have data
            guard let data = data, error == nil else {
                return
            }

            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                competion(.failure(APIError.invalidResponse))
                return
            }
            // Check the status code is between 200 and 299
            if !(200..<300).contains(urlResponse.statusCode) {
                competion(.failure(APIError.invalidStatusCode))
                return
            }
            // Serealize JSON to generic type of T
            do {
                let decodedResult = try JSONDecoder().decode(T.self, from: data)
                competion(.success(decodedResult))
            } catch {
                debugPrint("Decoding failed due to : \(error.localizedDescription)")
                competion(.failure(APIError.decodingError))
            }
        }
        // Start the request
        task.resume()
    }
}
