//
//  ParseHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/9/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class ParseHandler {

    let urlString = "https://my-json-server.typicode.com/alekseeva8/json-db/db"

    func getData(completionHanndler: @escaping (SearchResponse) -> Void) {
        APIHandler.requestDataToAPI(urlString: urlString) { (data) in
            do {
                let json = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completionHanndler(json)
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
    }
}
