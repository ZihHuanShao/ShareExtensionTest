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
    @IBOutlet weak var myTableView: UITableView!
    let manager = FavoriteManager.shareInstance
    let fileObjects = FavoriteManager.shareInstance.getFavoriteData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDataSrc()
        
        if let _ = fileObjects {
            for fileObject in fileObjects! {
                print("fileObject: \(fileObject)")
                
                switch fileObject.type {
                case .publicJpeg:
                    
                    let fileSize = getSize(url: fileObject.url)
                    
                    print("fileSize: \(fileSize)")
                
                case .publicPng:
                    let fileSize = getSize(url: fileObject.url)
                    print("fileSize: \(fileSize)")
                    
                default:
                    print("hello")
                }
                print("")
            }
        }
        
        
        let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest")
        if let dict = userDefault?.dictionary(forKey: "img") {
            myImageView.image = UIImage(data: dict["image"] as! Data)
            print("name: \(dict["name"])")
            
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
    
    func updateDataSrc() {
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    func getSize(url: URL) -> UInt64? {
        do {
            url.startAccessingSecurityScopedResource()
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            url.stopAccessingSecurityScopedResource()
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

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = fileObjects {
            return fileObjects!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myTableViewCell
        if let _ = fileObjects {
            cell.textLabel!.text = fileObjects![indexPath.row].name
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = fileObjects {
            let activityViewController = UIActivityViewController(activityItems: [fileObjects![indexPath.row].url.path], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
        

        
    }
}
