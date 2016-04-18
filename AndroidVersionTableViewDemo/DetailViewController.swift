//
//  ViewController.swift
//  AndroidVersionTableViewDemo
//
//  Created by HackerU on 18/04/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data:AndroidVersion?  = versions[0]
    
    @IBOutlet weak var versionNumberLabel: UILabel!
    @IBOutlet weak var versionDescriptionLabel: UILabel!
    @IBOutlet weak var versionImageView: UIImageView!
    @IBOutlet weak var versionNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        versionImageView.layer.cornerRadius = 4
        versionImageView.layer.borderWidth = 2
        versionImageView.layer.borderColor = UIColor.blackColor().CGColor
 
        
        versionImageView.image = UIImage(named: (data?.imageName)!)
        versionNameLabel.text = data?.name
        versionNumberLabel.text = data?.version.description
        versionDescriptionLabel.text = data?.details
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

