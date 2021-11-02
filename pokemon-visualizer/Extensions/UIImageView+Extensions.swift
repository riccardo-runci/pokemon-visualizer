//
//  UIImage+Extensions.swift
//  pokemon-visualizer
//
//  Created by Riccardo Runci on 26/10/21.
//

import UIKit
import Alamofire

extension UIImageView {
    func setImageFromUrl(url: URL?, placeholder: UIImage? = nil){
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
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false), let image = UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(url.lastPathComponent).path) {
            activityIndicator.removeFromSuperview()
            self.image = image
            return
        }

        AF.request(url).responseData { response in
            activityIndicator.removeFromSuperview()
            if let data = response.data {
                guard let result = UIImage(data: data) else {
                    self.image = placeholder
                    return
                }
                self.image = result
                guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                let fileURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
                   guard let data = result.pngData() else { return }
                   if FileManager.default.fileExists(atPath: fileURL.path) {
                       do {
                           try FileManager.default.removeItem(atPath: fileURL.path)
                           print("Removed old image")
                       } catch let removeError {
                           print("couldn't remove file at path", removeError)
                       }
                   }
                   do {
                       try data.write(to: fileURL)
                   } catch let error {
                       print("error saving file with error", error)
                   }
               }
            else{
                self.image = placeholder
            }
        }
    }
}
