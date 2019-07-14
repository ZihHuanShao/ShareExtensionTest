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
        if type == ContentType.publicPlainText.rawValue {
            present(UIActivityViewController(activityItems: [shareItem as! String], applicationActivities: nil), animated: true, completion: nil)
        } else {
            present(UIActivityViewController(activityItems: [shareItem as! URL], applicationActivities: nil), animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = name
        lblType.text = type
        lblSize.text = size
    }

}
