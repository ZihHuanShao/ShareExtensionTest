////
////  FavoriteManager.swift
////  SwiftRadio
////
////  Created by Wesley Chen on 2018/9/17.
////  Copyright © 2018 matthewfecher.com. All rights reserved.
////
//
//import Foundation
//
//class FavoriteManager: NSObject {
//
////    let userDefault = UserDefaults.standard
//    let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest")
//    let storeKey    = "com.TzuHuanShao.PrjThreeDTouchQuickDial"
//
//    static let shareInstance: FavoriteManager = {
//        let favoriteManager = FavoriteManager()
//        return favoriteManager
//    }()
//
//    func isEmpty() -> Bool {
//        var tmpArray: [DialRecord]?
//        tmpArray = self.decodeObject()
//        return tmpArray?.count == 0 ? true : false
//    }
//
//    func isExistFavoriteData(_ dialRecord: DialRecord) -> Bool {
//        var tmpArray: [DialRecord]?
//
//        if !self.isEmpty() {
//            tmpArray = self.decodeObject()
//            return tmpArray!.contains(where: {$0 == dialRecord}) ? true : false
//        } else {
//            return false
//        }
//    }
//
//    func setFavoriteData(_ dialRecord: DialRecord) {
//        if !self.isEmpty() {
//            self.modifiedFavoriteData(dialRecord)
//        } else {
//            var tmpArray = [DialRecord]()
//            tmpArray.append(dialRecord)
//
//            let data = self.encodeObject(tmpArray)
//            self.setUserDefault(data)
//        }
//    }
//
//    func getFavoriteData() -> [DialRecord]? {
//        var tmpArray: [DialRecord]?
//
//        if !self.isEmpty() {
//            tmpArray = self.decodeObject()
//            return tmpArray
//        } else {
//            return tmpArray
//        }
//    }
//
//    func deleteFavoriteData(_ dialRecord: DialRecord) {
//        if !self.isEmpty() {
//            var tmpArray: [DialRecord]?
//            tmpArray = self.decodeObject()
//
//            if let index = tmpArray!.index(where: { $0 == dialRecord }) {
//                tmpArray?.remove(at: index)
//                let data = self.encodeObject(tmpArray!)
//                self.setUserDefault(data)
//            }
//        }
//    }
//
//    private func modifiedFavoriteData(_ dialRecord: DialRecord) {
//        var tmpArray: [DialRecord]?
//        tmpArray = self.decodeObject()
//        tmpArray?.append(dialRecord)
//
//        let data = self.encodeObject(tmpArray!)
//        self.setUserDefault(data)
//    }
//
//    private func decodeObject() -> [DialRecord] {
//        if let storeData = userDefault.data(forKey: storeKey) {
//            //let encodeObject = NSKeyedUnarchiver.unarchiveObject(with: storeData) as! [RadioStation]
//            let encodeObject = try? PropertyListDecoder().decode([DialRecord].self, from: storeData) //TODO
//            return encodeObject!
//        } else {
//            return [DialRecord]()
//        }
//    }
//
//    private func encodeObject(_ data: Any) -> Data {
//        //let data = NSKeyedArchiver.archivedData(withRootObject: data)
//        let data = try? PropertyListEncoder().encode(data as! [DialRecord])
//        return data!
//    }
//    
//    private func setUserDefault(_ data: Data) {
//        userDefault.set(data, forKey: storeKey)
//        userDefault.synchronize()
//    }
//}
