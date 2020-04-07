//
//  NetworkService.swift
//  rss_client
//
//  Created by temir on 03.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import Foundation

protocol Networking: class {
    func getData(completion: @escaping((Data?, Error?) -> Void))
}

class NetworkService: Networking {
    
    func getData(completion: @escaping((Data?, Error?) -> Void)) {
        let urlString = "https://meduza.io/rss/podcasts/meduza-v-kurse"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, error)
            }
            if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
}
