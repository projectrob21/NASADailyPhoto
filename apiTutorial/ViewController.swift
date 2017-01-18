//
//  ViewController.swift
//  apiTutorial
//
//  Created by Robert Deans on 1/17/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var aPOD: APOD!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getAPODData { (APODData) in
            self.aPOD = APOD(data: APODData)
            OperationQueue.main.addOperation {
                self.titleLabel.text = self.aPOD.title
                self.textField.text = self.aPOD.explanation
                self.imageView.image = self.aPOD.hdurl
            }
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

