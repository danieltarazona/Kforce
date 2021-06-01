//
//  RequestManager.swift
//  Core
//
//  Created by Daniel Tarazona on 5/20/21.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class RequestManager {
    let session = URLSession.shared
    var requestURL: String = ""
    
    var semaphore = DispatchSemaphore (value: 0)

    func download<T: Codable>(url: String, type: T.Type, completion: (@escaping (T?, Error?) -> Void )) {
        print(url)
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                self.semaphore.signal()
                return
            }
            
            // print(String(data: data, encoding: .utf8)!)

            do {
                let json = try newJSONDecoder().decode(T.self, from: data)
                completion(json, nil)
            } catch {
                print(error)
            }
            
            self.semaphore.signal()
            
        }.resume()
        
        semaphore.wait()
    }
    
    func task<T: Codable>(endpoint: String, type: T.Type, completion: (@escaping (T?, Error?) -> Void )) {
        let requestURL = requestURL.appending(endpoint)
        print(requestURL)
        if let url = URL(string: requestURL) {
            _ = session.task(with: url, type: type) { data, response, error in
                let response = response as? HTTPURLResponse
                if error == nil {
                    if let data = data, let response = response, response.statusCode == 200 {
                        completion(data, nil)
                    }
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
    
    func getImage(_ path: String, completion: (@escaping (Data?) -> Void )) {
        if let url = URL(string: path) {
            session.dataTask(with: url) { (data, response, error) in
                let response = response as? HTTPURLResponse
                if error == nil {
                    if let data = data, let response = response, response.statusCode == 200 {
                        completion(data)
                    }
                } else {
                    print(error?.localizedDescription ?? "")
                }
            }.resume()
        }
    }
    
    func request<T: Codable>(
        object: RequestObject,
        type: T.Type,
        completion: ((_ response: T?, _ error: Error?) -> Void)? = nil
    ) {

        func unwrap<T>(_ anyT: T) -> Any {
            let mirror = Mirror(reflecting: anyT)
            guard mirror.displayStyle == .optional, let first = mirror.children.first else {
                return anyT
            }
            return first.value
        }

        var URL = object.URL

        let objectMirror = Mirror(reflecting: object)

        for (property, values) in objectMirror.children {
            if let property = property {
                if case Optional<Any>.none = values { } else {
                    if let arrayValue = values as? [Any] {
                        for value in arrayValue {
                            URL.append("?\(property)=\(unwrap(value))")
                        }
                    } else {
                        URL.append("?\(property)=\((unwrap(values)))")
                    }
                }
            }
        }

        for (property, values) in objectMirror.superclassMirror!.children {
            if let property = property {
                if case Optional<Any>.none = values { } else {
                    if property == "URL" { } else {
                        URL.append("?\(property)=\((unwrap(values)))")
                    }
                }
            }
        }

        requestManager.download(url: URL, type: type) { response, error in
            if let response = response {
                completion?(response, nil)
            }
        }
    }
}
