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
    
    @IBAction func btnShare(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    var name: String!
    var type: String!
    var size: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = name
        lblType.text = type
        lblSize.text = size
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
