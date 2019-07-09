//
//  ViewController.swift
//  ShareExtensionTest
//
//  Created by maxkitmac on 2019/7/4.
//  Copyright © 2019年 fredshao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        if let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest") {
            if let url = userDefault.url(forKey: "share_url") {
                myLabel.text = url.absoluteString
            }
        } else {
            print("ERROR: suiteName")
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        
        if let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest") {
            

            print("viewWillAppear")
            if let rmpData = userDefault.object(forKey: "tmpJPG") as? Data {
                print("viewWillAppear again")
               //let data = try ? PropertyListDecoder.decode(rmpData)
                //let encodeObject = try? PropertyListDecoder().decode([DialRecord].self, from: rmpData)
                let encodeObject = try? PropertyListDecoder().decode(Data.self, from: rmpData)
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: encodeObject!)
                    //self.myImageView.image = UIImage(data: Data)
                }
            }
        }
        
        
        
        /*
        if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.maxkit.fred.ShareExtensionTest") {
            let imagePath = shareUrl.appendingPathComponent("IMG_2027.JPG")
            
            do
            {
                let data = try Data(contentsOf: imagePath)
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data:data)
                }
            }
            catch {
                print(error)
            }
        }*/
 
        
    }
}

