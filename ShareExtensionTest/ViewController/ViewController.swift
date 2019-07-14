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
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func updateSrc() {
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    func previewObject(image: UIImage) {
        DispatchQueue.main.async {
            self.myImageView.image = image
        }
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
            
            switch fileObjects![indexPath.row].type {
                
            case .publicJpeg:
                
                // METHOD 1: FileManager
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: suiteName) {
                    let imagePath = shareUrl.appendingPathComponent(fileObjects![indexPath.row].url!.lastPathComponent)
                    previewObject(image: UIImage(contentsOfFile: imagePath.path)!)
                    
                    /*---
                    // Can use 'Data' type as well
                    let data = try? Data(contentsOf: imagePath)
                    previewObject(image: UIImage(data: data!)!)
                    ---*/
                }
                
                /*---
                // METHOD 2: UserDefaults
                if let userDefault = UserDefaults.init(suiteName: suiteName) {
                    let data = userDefault.data(forKey: fileObjects![indexPath.row].name)
                    previewObject(image: UIImage(data: data!)!)
                }
                ---*/
                
            case .publicUrl:
                previewObject(image: UIImage(named: "url.png")!)
                
            case .publicZip_archive:
                previewObject(image: UIImage(named: "zip.png")!)
                
            case .comAppleIworkPagesSffpages:
                previewObject(image: UIImage(named: "pages.png")!)
                
            case .publicJson:
                previewObject(image: UIImage(named: "json.png")!)
                
            case .publicPng:
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: suiteName) {
                    let imagePath = shareUrl.appendingPathComponent(fileObjects![indexPath.row].url!.lastPathComponent)
                    previewObject(image: UIImage(contentsOfFile: imagePath.path)!)
                }
                
            case .publicPlainText:
                previewObject(image: UIImage(named: "text.png")!)

//            case .publicMpeg4:
            default:
                print("default")
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let _ = fileObjects {
            let storyboard = UIStoryboard(name: "InfoView", bundle: nil)
            let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            
            infoVC.name = fileObjects![indexPath.row].name
            infoVC.type = fileObjects![indexPath.row].type.rawValue
            infoVC.size = String(fileObjects![indexPath.row].size)
            
            
            if fileObjects![indexPath.row].type == .publicPlainText {
                infoVC.shareItem = fileObjects![indexPath.row].name
            } else {
                if let shareUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: suiteName) {
                    let dataPath = shareUrl.appendingPathComponent(fileObjects![indexPath.row].url!.lastPathComponent)
                    infoVC.shareItem = dataPath
                }
            }

            navigationController?.pushViewController(infoVC, animated: true)
            
        }
    }
}


