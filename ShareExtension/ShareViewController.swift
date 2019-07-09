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
                                    
                                    if let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest") {
                                        
                                        do {
                                            print("hello")
                                            let tmpData = try Data(contentsOf: data as! URL)
                                            print("world")
                                            let data = try?  PropertyListEncoder().encode(tmpData)
                                            print("data", data!)
                                            userDefault.set(data!, forKey: "tmpJPG")
                                            
                                            print("write data")
                                        } catch {
                                            print("error: ", error.localizedDescription)
                                        }
                                        
                                    }
                                    
  
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
