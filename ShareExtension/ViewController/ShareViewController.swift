//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by maxkitmac on 2019/7/4.
//  Copyright © 2019年 fredshao. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    let suiteName = "group.maxkit.fred.ShareExtensionTest"
    let manager = FavoriteManager.shareInstance
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    

    override func didSelectPost() {
        
        if let inputItems = extensionContext!.inputItems as? [NSExtensionItem] {
            
            for inputItem in inputItems {
                
                if let attachments = inputItem.attachments {
                    
                    for attachment in attachments {
                        
                        print("attachment: \(attachment)")
                        
                        switch (true) {
                        case attachment.hasItemConformingToTypeIdentifier(ContentType.publicJpeg.rawValue):
                            self.retriveAttachment(attachment: attachment, type: .publicJpeg)
                        
                        case attachment.hasItemConformingToTypeIdentifier(ContentType.publicUrl.rawValue):
                            
                            switch (true) {
                            case attachment.hasItemConformingToTypeIdentifier(ContentType.publicZip_archive.rawValue):
                                
                                switch (true) {
                                case attachment.hasItemConformingToTypeIdentifier(ContentType.comAppleIworkPagesSffpages.rawValue):
                                    self.retriveAttachment(attachment: attachment, type: .comAppleIworkPagesSffpages)

                                default:
                                    self.retriveAttachment(attachment: attachment, type: .publicZip_archive)
                                }
                             
                            case attachment.hasItemConformingToTypeIdentifier(ContentType.publicJson.rawValue):
                                self.retriveAttachment(attachment: attachment, type: .publicJson)
                            
                            case attachment.hasItemConformingToTypeIdentifier(ContentType.publicPng.rawValue):
                                self.retriveAttachment(attachment: attachment, type: .publicPng)
                                
                            case attachment.hasItemConformingToTypeIdentifier(ContentType.publicPlainText.rawValue):
                                self.retriveAttachment(attachment: attachment, type: .publicPlainText)
                                
                            case attachment.hasItemConformingToTypeIdentifier(ContentType.publicMpeg4.rawValue):
                                self.retriveAttachment(attachment: attachment, type: .publicMpeg4)
                                
                            default:
                                self.retriveAttachment(attachment: attachment, type: .publicUrl)
                            }
                            
                        default:
                            print("default attachment: \(attachment)")
                        }

                    }
                }
            }
        }
        
        

        print("Done")
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    

    // MARK: - To get info of attachment
    func retriveAttachment(attachment: NSItemProvider, type: ContentType) {
        attachment.loadItem(forTypeIdentifier: type.rawValue, options: nil) {
            (data, error) in
            if error != nil { print(error!.localizedDescription) }
            if let url = data as? URL {
                
                // Enable permission
                url.startAccessingSecurityScopedResource()
                
                let fileObject = FileObject(name: url.lastPathComponent, type: type, url: url, size: self.getSize(atPath: url.path)!)
                
                print("fileObject: \(fileObject)")
                
                self.manager.setFavoriteData(fileObject)
                
                // METHOD: FileManager
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.suiteName) {
                    do {
                        let tmpData = try Data(contentsOf: url)
                        
                        let imagePath = shareUrl.appendingPathComponent(url.lastPathComponent)
                        print("imagePath: \(imagePath)")
                        
                        if FileManager().fileExists(atPath: imagePath.path) {
                            print("imagePath existed!")
                            try! FileManager().removeItem(at: imagePath)
                            print("remove successed")
                        }
                        
                        try! tmpData.write(to: imagePath)
                        print("write successed")
                           
                        
                    } catch {
                        print(error)
                    }
                    
                    
                    
                }
                
                
                /*
                // METHOD: UserDefaults
                if let userDefault = UserDefaults.init(suiteName: self.suiteName) {
                    do {
                        let tmpData = try Data(contentsOf: url)
                        userDefault.set(tmpData, forKey: url.lastPathComponent)
                        print("write success")
                        
                    } catch {
                        print(error)
                    }
                }
                */
 
                print("")
                
                // Disable permission
                url.stopAccessingSecurityScopedResource()
                
                
            }
        }
        
    }
    
    
    func getSize(atPath path: String) -> UInt64? {
        
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            let fileSize = attr[FileAttributeKey.size] as! UInt64
            
            return fileSize
        } catch {
            
            // Return 0, if a web url
            return 0
        }
    }
    
    
}
