//
//  FileDownloader.swift
//  Brandi
//
//  Created by Ryan Lee on 2016. 10. 26..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation

open class FileDownloader {
    public static func loadFileFromUrl(_ url: URL, completion: ((_ success: Bool, _ data: Data?) -> Void)?) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler:
            { data, response, error in
                if error == nil {
                    //success
                    completion?(true, data)
                } else {
                    //error
                    completion?(false, nil)
                }
            }
        )
        task.resume()
    }
}
