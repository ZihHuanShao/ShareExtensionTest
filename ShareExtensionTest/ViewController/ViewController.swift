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
    
    let manager     = FavoriteManager.shareInstance
    let fileObjects = FavoriteManager.shareInstance.getFavoriteData()
    let suiteName   = "group.maxkit.fred.ShareExtensionTest"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateSrc()
        
        guard let fileObjects = manager.getFavoriteData() else { return }
        
        for fileObject in fileObjects {
            print("fileObject: \(fileObject)")
            
            switch fileObject.type {
            case .publicJpeg:
                if let userDefault = UserDefaults.init(suiteName: suiteName) {
                    let imgData = userDefault.data(forKey: fileObject.name)
                    DispatchQueue.main.async {
                        self.myImageView.image = UIImage(data: imgData!)
                    }
                }
                
                
            case .publicPng:
                if let userDefault = UserDefaults.init(suiteName: suiteName) {
                    let imgData = userDefault.data(forKey: fileObject.name)
                    DispatchQueue.main.async {
                        self.myImageView.image = UIImage(data: imgData!)
                    }
                }
            default:
                print("hello")
            }
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

    }
    
    func updateSrc() {
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    
}

// MRAK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = fileObjects {
            return fileObjects!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! myTableViewCell
        if let _ = fileObjects {
            cell.textLabel!.text = fileObjects![indexPath.row].name
        }
        
        return cell
    }
    
   
}

// MRAK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = fileObjects {
            
            
            
            /*
            let activityViewController = UIActivityViewController(activityItems: [fileObjects![indexPath.row].url.path], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
            */
        }
    }
}
