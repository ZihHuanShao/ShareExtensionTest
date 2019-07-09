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
    let manager = FavoriteManager.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let fileObjects = manager.getFavoriteData() else { return }
        
        for fileObject in fileObjects {
            print(fileObject)
        }
        
        /*
        // MARK: - Support type: kUTTypeURL
        if let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest") {
            if let url = userDefault.url(forKey: "share_url") {
                myLabel.text = url.absoluteString
            }
        } else {
            fatalError()
        }
        
        
        
        if let tempPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.maxkit.fred.ShareExtensionTest") {
            do{
                let fileList = try FileManager.default.contentsOfDirectory(atPath: tempPath.path)
                for file in fileList{
                    print(file)
                }
            }
            catch{
                print("Cannot list directory")
            }
        }
        */
    }

    override func viewWillAppear(_ animated: Bool) {
        
        
        /*
        // MARK: - Support type: kUTTypeImage
        // METHOD 1: 讀取失敗，UIImage(contentsOfFile: imagePath.path) always回傳nil
        if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.maxkit.fred.ShareExtensionTest") {
            let imagePath = shareUrl.appendingPathComponent("IMG_2093.JPG")
            print("imagePath: \(imagePath)")
            print("imagePath.path: \(imagePath.path)")
            let image = UIImage(contentsOfFile: imagePath.path)
            
            DispatchQueue.main.async {
                self.myImageView.image = image
            }
        }
        */
        
        
        
        /*
        // MARK: - Support type: kUTTypeImage
        // METHOD 2: 讀取OK
        if let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest") {

            print("viewWillAppear")
            if let tmpData = userDefault.object(forKey: "tmpJPG") as? Data {
                print("viewWillAppear again")
                let encodeObject = try? PropertyListDecoder().decode(Data.self, from: tmpData)
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: encodeObject!)
                }
            }
            
        }
        if let tempPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.maxkit.fred.ShareExtensionTest") {
            do{
                let fileList = try FileManager.default.contentsOfDirectory(atPath: tempPath.path)
                for file in fileList{
                    print(file)
                }
            }
            catch{
                print("Cannot list directory")
            }
        }
        */
    }
}

