//
//  HTTPHandler.swift
//  TwitchListing
//
//  Created by Szymon Kazmierczak on 28/05/2017.
//  Copyright © 2017 Szymon Kazmierczak. All rights reserved.
//
//
//  HTTPHandler.swift
//  demo-app
//
//  Created by Szymon Kazmierczak on 24/05/2017.
//  Copyright © 2017 Szymon Kazmierczak. All rights reserved.

import Foundation

class HTTPHandler {
    static func getJson(urlString: String, completionHandler: @escaping (Data?) -> (Void)) {
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        var urlRequest = URLRequest(url: url!)
        
        // set headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        // TODO: Extract api key
        urlRequest.setValue(REPLACE_WITH_YOUR_CLIENT_ID, forHTTPHeaderField: "Client-ID")
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        print("URL being used is \(url!)")
//        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("request completed with code: \(statusCode)")
                if (statusCode == 200) {
                    print("return to completion handler with the data")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making the HTTP request***")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
}
