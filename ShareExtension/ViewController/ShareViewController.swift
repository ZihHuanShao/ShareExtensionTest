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
                        
                        case attachment.hasItemConformingToTypeIdentifier(ContentType.publicPng.rawValue):
                            self.retriveAttachment(attachment: attachment, type: .publicPng)
                            
                        case attachment.hasItemConformingToTypeIdentifier(ContentType.publicPlainText.rawValue):
                            self.retriveAttachment(attachment: attachment, type: .publicPlainText)
                            
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
                                
                            case attachment.hasItemConformingToTypeIdentifier(ContentType.publicMpeg4.rawValue):
                                self.retriveAttachment(attachment: attachment, type: .publicMpeg4)
                                
                            case attachment.hasItemConformingToTypeIdentifier(ContentType.publicPlainText.rawValue):
                                self.retriveAttachment(attachment: attachment, type: .publicPlainText)
                                
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
            //print("data: \(data)")
            
            if error != nil { print(error!) }
            
            if let url = data as? URL {
                
                // Enable permission
                url.startAccessingSecurityScopedResource()

                self.setToObjects(name: url.lastPathComponent, type: type, url: url, size: self.getSize(atPath: url.path)!)
        
                // MARK: - METHOD 1: FileManager
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.suiteName) {
                    do {
                        let tmpData = try Data(contentsOf: url)
                        let tmpDataPath = shareUrl.appendingPathComponent(url.lastPathComponent)
                        
                        /*---
                        // Remove duplicated item
                        if FileManager().fileExists(atPath: imagePath.path) { try! FileManager().removeItem(at: imagePath) }
                        ---*/
                        
                        try! tmpData.write(to: tmpDataPath)
                        print("write successed")
                        
                    } catch {
                        print(error)
                    }
   
                }
                // MARK END
                
                
                /*---
                 // MARK: - METHOD 2: UserDefaults
                if let userDefault = UserDefaults.init(suiteName: self.suiteName) {
                    do {
                        let tmpData = try Data(contentsOf: url)
                        userDefault.set(tmpData, forKey: url.lastPathComponent)
                        print("write success")
                        
                    } catch {
                        print(error)
                    }
                }
                // MARK END
                ---*/
 
                print("")
                
                // Disable permission
                url.stopAccessingSecurityScopedResource()
                
            } else if let str = data as? String {
                
                // No url and size exists, if a simple text
                self.setToObjects(name: str, type: type, url: nil, size: 0)
                
            } else {
                print("Can not unwrapping to type.")
            }
        }
        
    }
    
    // Save each item info to object array
    func setToObjects(name: String, type: ContentType, url:  URL?, size: UInt64) {
        let fileObject = FileObject(name: name, type: type, url: url, size: size)
        self.manager.setFavoriteData(fileObject)
        print("fileObject: \(fileObject)")
        
    }
    
    func getSize(atPath path: String) -> UInt64? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            let fileSize = attr[FileAttributeKey.size] as! UInt64
            return fileSize
            
        } catch {
            
            // Return 0, if web url
            return 0
            
        }
    }
    
}
