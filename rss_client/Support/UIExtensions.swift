//
//  UIExtensions.swift
//  rss_client
//
//  Created by temir on 08.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(with url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) {[weak self] (data, _, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let fetchedData = data else { return }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: fetchedData)
                }
            }.resume()
        }
    }
}
