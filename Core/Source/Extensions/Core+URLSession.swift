//
//  Core+URLSession.swift
//  Core
//
//  Created by Daniel Tarazona on 5/22/21.
//

import Foundation

extension URLSession: URLSessionProtocol {
    
    func task<T: Codable>(
        with url: URL,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func task<T: Codable>(
        with request: URLRequest,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return self.codableTask(with: request, completionHandler: completionHandler)
    }
    
    func task<T: Codable>(
        with url: URL,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return self.codableTask(with: url, type: type, completionHandler: completionHandler)
    }
    
    func task<T: Codable>(
        with request: URLRequest,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return self.codableTask(with: request, type: type, completionHandler: completionHandler)
    }
    
    func codableTask<T: Codable>(
        with request: URLRequest,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func codableTask<T: Codable>(
        with url: URL,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func codableTask<T: Codable>(
        with url: URL,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            
            completionHandler(try? newJSONDecoder().decode(type.self, from: data), response, nil)
        }
    }
    
    func codableTask<T: Codable>(
        with request: URLRequest,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(type, from: data), response, nil)
        }
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
extension URLSessionDataTask: URLSessionDownloadTaskProtocol {}

protocol URLSessionDataTaskProtocol { func resume() }
protocol URLSessionDownloadTaskProtocol { func resume() }

protocol URLSessionProtocol {
    func task<T: Codable>(
        with request: URLRequest,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
    
    func task<T: Codable>(
        with request: URLRequest,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
    
    func task<T: Codable>(
        with url: URL,
        type: T.Type,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
    
    func task<T: Codable>(
        with url: URL,
        completionHandler: @escaping (T?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}
