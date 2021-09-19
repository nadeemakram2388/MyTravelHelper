//
//  NetworkClient.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
public enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}


class NetworkClient {
    // MARK: Typealias
    typealias CompletionResult = (Result<Data?, NetworkError>) -> Void
    
    // MARK: - Shared Instance
    static let shared = NetworkClient(session: URLSession.shared)
    
    // MARK: - Private Properties
    private let session: NetworkSessionProtocol
    private var task: NetworkDataTaskProtocol?
    private var completionResult: CompletionResult?
    
    // MARK: - Initialiser
    init(session: NetworkSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Data Task Helper
    func dataTask(_ request: NetworkRequestProtocol, completion: @escaping CompletionResult) {
        completionResult = completion
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: AppConstants.Service.timeout)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        task = session.dataTask(with: urlRequest) { (data, response, error) in
            //return error if there is any error in making request
            if let error = error {
                self.completionResult(.failure(NetworkError(error.localizedDescription)))
                return
            }
            
            //check response
            if let response = response, response.isSuccess {
                if let data = data {
                    self.completionResult(.success(data))
                }
                
                if response.httpStatusCode == 204 {
                    self.completionResult(.success(nil))
                }
            } else {
                let commonErrorMessage = AppText.somthingWentWrong.string
                guard let data = data else {
                    self.completionResult(.failure(NetworkError(commonErrorMessage)))
                    return
                }
                do {
                    let serverError = try JSONDecoder().decode(ServerError.self, from: data)
                    self.completionResult(.failure(NetworkError(serverError.error ?? commonErrorMessage)))
                } catch {
                    self.completionResult(.failure(NetworkError(commonErrorMessage)))
                }
            }
        }
        
        //Resume task
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private Helper Function
    private func completionResult(_ result: Result<Data?, NetworkError>) {
        DispatchQueue.main.async {
            self.completionResult?(result)
        }
    }
}

