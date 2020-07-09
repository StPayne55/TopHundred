//
//  Extensions.swift
//  TopHundred
//
//  Created by Stephen Payne on 7/8/20.
//  Copyright © 2020 Stephen Payne. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(url: URL, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async() {
                self.contentMode =  contentMode
                if let data = data {
                    guard let image = UIImage(data: data) else { return }

                    self.image = image
                }
            }
        }.resume()
    }
}
