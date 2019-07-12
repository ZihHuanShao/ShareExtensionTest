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
    @IBOutlet weak var lblTypeTitle: UILabel!
    
    let manager     = FavoriteManager.shareInstance
    let fileObjects = FavoriteManager.shareInstance.getFavoriteData()
    let suiteName   = "group.maxkit.fred.ShareExtensionTest"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateSrc()
        lblTypeTitle.text = ""
//        myTableView.register(myTableViewCell.self, forCellReuseIdentifier: "CELL")
        guard let fileObjects = manager.getFavoriteData() else { return }
        
        for fileObject in fileObjects {
            print("fileObject: \(fileObject)")
            
            switch fileObject.type {
//            case .publicJpeg:
                /*
                // METHOD: FileManager
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: suiteName) {
                    let imagePath = shareUrl.appendingPathComponent(fileObject.url.lastPathComponent)
                    print("imagePath: \(imagePath)")
                    
                    do {
                        let fdata = try Data(contentsOf: imagePath)
                        print("fdata.count:\(fdata)")
                        DispatchQueue.main.async {
                            self.myImageView.image = UIImage(contentsOfFile: imagePath.path)
                        }
                    } catch {
                        print(error)
                    }

                }
                */
                
                /*
                // METHOD: UserDefaults
                if let userDefault = UserDefaults.init(suiteName: suiteName) {
                    let imgData = userDefault.data(forKey: fileObject.name)
                    DispatchQueue.main.async {
                        self.myImageView.image = UIImage(data: imgData!)
                    }
                }
                */
                
            case .publicPng:
                
                // METHOD: FileManager
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: suiteName) {
                    let imagePath = shareUrl.appendingPathComponent(fileObject.url.lastPathComponent)
                    print("imagePath: \(imagePath)")
                    
                    do {
                        let fdata = try Data(contentsOf: imagePath)
                        print("fdata.count:\(fdata)")
                        DispatchQueue.main.async {
                            self.myImageView.image = UIImage(contentsOfFile: imagePath.path)
                        }
                    } catch {
                        print(error)
                    }
                    
                }
                
                /*
                // METHOD: UserDefaults
                if let userDefault = UserDefaults.init(suiteName: suiteName) {
                    let imgData = userDefault.data(forKey: fileObject.name)
                    DispatchQueue.main.async {
                        self.myImageView.image = UIImage(data: imgData!)
                    }
                }
                */
                
            default:
                print("hello")
            }
        }

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
            let storyboard = UIStoryboard(name: "InfoView", bundle: nil)
            let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            
            infoVC.name = fileObjects![indexPath.row].name
            infoVC.type = fileObjects![indexPath.row].type.rawValue
            infoVC.size = String(fileObjects![indexPath.row].size)
            
            
            switch fileObjects![indexPath.row].type {
            case .publicJpeg:
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: suiteName) {
                    let imagePath = shareUrl.appendingPathComponent(fileObjects![indexPath.row].url.lastPathComponent)
                    print("imagePath: \(imagePath)")
                    
                    do {
                        let fdata = try Data(contentsOf: imagePath)
                        print("fdata.count:\(fdata)")
                        DispatchQueue.main.async {
                            self.myImageView.image = UIImage(contentsOfFile: imagePath.path)
                        }
                    } catch {
                        print(error)
                    }
                    
                }
                
                lblTypeTitle.text = "JPG"
            case .publicUrl:
                infoVC.url  = fileObjects![indexPath.row].url
                lblTypeTitle.text = "Web"
            default:
                lblTypeTitle.text = "--"
            }
            
            navigationController?.pushViewController(infoVC, animated: true)
            
         }
    }
}
