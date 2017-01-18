//
//  APIClient.swift
//  apiTutorial
//
//  Created by Robert Deans on 1/17/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class APIClient {
    
    class func getAPODData(completion: @escaping ([String:Any]) -> Void) {
        
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=LPVOyGKH2GauD1MUGCfDL1uXMqkRKMCqksUzU3u7") else { print("trouble unwrapping url"); return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { print("error unwrapping data"); return }
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
                completion(responseJSON)
            } catch {
                print("ERROR: \(error)")
            }
        }
        dataTask.resume()
        
    }
    
    
}

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse else { return }
            guard let mimeType = response?.mimeType else { return }
            guard let data = data else { return }
            
            if httpURLResponse.statusCode == 200 && mimeType.hasPrefix("image") && error == nil {
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async() { () -> Void in
                    self.image = image
                }
            }
        }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
}
