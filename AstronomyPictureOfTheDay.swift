//
//  AstronomyPictureOfTheDay.swift
//  apiTutorial
//
//  Created by Robert Deans on 1/17/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

struct APOD {
    let copyright: String
    let date: String
    let explanation: String
    var hdurl: UIImage?
    let title: String
 
    init(data: [String:Any]) {
        guard let safecopyright = data["copyright"] as? String,
            let safeDate = data["date"] as? String,
            let safeexplanation = data["explanation"] as? String,
            let safehdurlstring = data["hdurl"] as? String,
            let safetitle = data["title"] as? String
        
        else { fatalError() }
        
        let safeHDUrlStringHttps = safehdurlstring.replacingOccurrences(of: "http", with: "https")
        let safehdurl = URL(string: safeHDUrlStringHttps)
        self.copyright = safecopyright
        self.date = safeDate
        self.explanation = safeexplanation
        self.title = safetitle
        
        do {
            print("doing")
            print("URL \(safehdurl!)")
            let asd = try Data(contentsOf: safehdurl!)
            print(asd)
            self.hdurl = UIImage(data: asd)!
            
        } catch {
            print("image is nil")
            print("url string is \(safehdurlstring)")
            self.hdurl = nil
            return
        }
        
    }
    
}
