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
                            
                        case attachment.hasItemConformingToTypeIdentifier(ContentType.publicPng.rawValue):
                            self.retriveAttachment(attachment: attachment, type: .publicPng)
                            
                        default:
                            print("default attachment: \(attachment)")
                        }

                    }
                }
            }
        }
        
        

        print("heool")
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
            if error != nil { print(error!) }
            if let url = data as? URL {
                
                let fileObject = FileObject(name: url.lastPathComponent, type: type, url: url)
                url.startAccessingSecurityScopedResource()
                self.manager.setFavoriteData(fileObject)
                print("fileObject: \(fileObject)")
                print("getSize: \(self.getSize(atPath: url.path))")
                print("write data")
                print("")
                url.stopAccessingSecurityScopedResource()
                
                //////
                do {
                    url.startAccessingSecurityScopedResource()
                    let imageData = try Data(contentsOf: url)
                    let dict = ["image":imageData,
                                "name":url.lastPathComponent
                                ] as [String : Any]
                    let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest")
                    userDefault?.setValue(dict, forKey: "img")
                    print("write dict")
                    url.stopAccessingSecurityScopedResource()
                } catch {
                    fatalError().localizedDescription
                }
                //////
                
            }
            
        }
        
    }
    
    func getSize(atPath path: String) -> UInt64? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            let fileSize = attr[FileAttributeKey.size] as! UInt64
            
            /*
             let dict = attr as NSDictionary
             fileSize = dict.fileSize()
             */
            
            return fileSize
        } catch {
            print("getSize Error: \(error)")
            return nil
        }
    }
    
}
