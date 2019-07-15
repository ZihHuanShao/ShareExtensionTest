//
//  InfoViewController.swift
//  ShareExtensionTest
//
//  Created by maxkitmac on 2019/7/12.
//  Copyright © 2019年 fredshao. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    
    var name:      String!
    var type:      String!
    var size:      String!
    var url:       URL!
    var shareItem: Any!
    
    @IBAction func btnShare(_ sender: Any) {
        if let urlItem = shareItem as? URL {
            present(UIActivityViewController(activityItems: [urlItem], applicationActivities: nil), animated: true, completion: nil)
        } else if let stringItem = shareItem as? String { 
            present(UIActivityViewController(activityItems: [stringItem], applicationActivities: nil), animated: true, completion: nil)
        }

    }

    override func viewDidLoad() {
        lblName.text = name
        super.viewDidLoad()
        
        lblType.text = type
        lblSize.text = size
    }

}
