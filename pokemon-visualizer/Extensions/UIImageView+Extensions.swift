//
//  UIImage+Extensions.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit
import Alamofire

extension UIImageView {
    func setImageFromUrl(url: String?, placeholder: UIImage? = nil){
        self.image = nil
        guard let url = url else {
            self.image = placeholder
            return
        }
        let activityIndicator = UIActivityIndicatorView()
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        AF.request(url).responseData { response in
            activityIndicator.removeFromSuperview()
            if let data = response.data {
                let result = UIImage(data: data)
                self.image = result
            }
            else{
                self.image = placeholder
            }
        }
    }
}
