//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by maxkitmac on 2019/7/4.
//  Copyright © 2019年 fredshao. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices


class ShareViewController: SLComposeServiceViewController {

    @IBOutlet weak var myImageView: UIImageView!
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    

    override func didSelectPost() {
        
        if let inputItems = extensionContext!.inputItems as? [NSExtensionItem] {
            
            
            for inputItem in inputItems {
                
                if let attachments = inputItem.attachments {
                    
                    for attachment in attachments {
                        
                        if attachment.hasItemConformingToTypeIdentifier(kUTTypeItem as String) {
                            
                            switch (true) {
                            
                            // MARK: - Support type: kUTTypeImage
                            case attachment.hasItemConformingToTypeIdentifier(kUTTypeImage as String):
                                
                                attachment.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil) {
                                    (data, error) in
                                    
                                    if error != nil { print("Something's wrong!") }
                                    
                                    
                                    // METHOD 1: 使用FileManager，直接將image寫入
                                    // 結果: 寫入OK，讀取失敗
                                    if let url = data as? URL {
                                        if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.maxkit.fred.ShareExtensionTest") {
                                            let imagePath = shareUrl.appendingPathComponent(url.lastPathComponent)
                                            print("url.lastPathComponent: \(url.lastPathComponent)")
                                            print("imagePatht: \(imagePath)")
                                            try? UIImage(named: url.lastPathComponent)?.jpegData(compressionQuality: 1)?.write(to: imagePath)
                                            print("write image")
                                        }
                                    }
 
                                    
                                    /*
                                    // METHOD 2: ，使用UserDefaults，先將得到的來源data轉為Data型別，做encode之後再寫入
                                    // 結果:  要寫第二次才會成功，讀取OK
                                    if let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest") {
                                        
                                        do {
                                            print("hello")
                                            let tmpData = try Data(contentsOf: data as! URL)
                                            print("data as! URL: \(data as! URL)")
                                            print("world")
                                            let data = try?  PropertyListEncoder().encode(tmpData)
                                            print("data", data!)
                                            userDefault.set(data!, forKey: "tmpJPG")
                                            
                                            print("write data")
                                        } catch {
                                            print("error: ", error.localizedDescription)
                                        }
                                        
                                    }
                                    */
                                    
                                }
                                break
                            
                            
                            // MARK: - Support type: kUTTypeURL
                            case attachment.hasItemConformingToTypeIdentifier(kUTTypeURL as String):
                                
                                attachment.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) {
                                    (data, error) in
                                    
                                    if error != nil { print("Something's wrong!") }
                                    
                                    if let shareUrl = data as? URL {
                                        
                                        // 寫入url
                                        if let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest") {
                                            userDefault.set(shareUrl, forKey: "share_url")
                                            print("shareUrl ->", shareUrl)
                                        }
                                    }
                                }
                                break
           
                            default:
                                print("Wait, attachment: \(attachment)")
                            }
                            
                        } else {
                            print("ERROR TYPE: \(attachment)")
                        }

                    }
                }
            }
        }
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
