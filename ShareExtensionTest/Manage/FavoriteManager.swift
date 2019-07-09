

import Foundation

class FavoriteManager: NSObject {

//    let userDefault = UserDefaults.standard
    let userDefault = UserDefaults.init(suiteName: "group.maxkit.fred.ShareExtensionTest")
    let storeKey    = "com.TzuHuanShao.PrjThreeDTouchQuickDial"

    static let shareInstance: FavoriteManager = {
        let favoriteManager = FavoriteManager()
        return favoriteManager
    }()

    func isEmpty() -> Bool {
        var tmpArray: [FileObject]?
        tmpArray = self.decodeObject()
        return tmpArray?.count == 0 ? true : false
    }

    func isExistFavoriteData(_ fileObject: FileObject) -> Bool {
        var tmpArray: [FileObject]?

        if !self.isEmpty() {
            tmpArray = self.decodeObject()
            return tmpArray!.contains(where: {$0 == fileObject}) ? true : false
        } else {
            return false
        }
    }

    func setFavoriteData(_ fileObject: FileObject) {
        if !self.isEmpty() {
            self.modifiedFavoriteData(fileObject)
        } else {
            var tmpArray = [FileObject]()
            tmpArray.append(fileObject)

            let data = self.encodeObject(tmpArray)
            self.setUserDefault(data)
        }
    }

    func getFavoriteData() -> [FileObject]? {
        var tmpArray: [FileObject]?

        if !self.isEmpty() {
            tmpArray = self.decodeObject()
            return tmpArray
        } else {
            return tmpArray
        }
    }

    func deleteFavoriteData(_ fileObject: FileObject) {
        if !self.isEmpty() {
            var tmpArray: [FileObject]?
            tmpArray = self.decodeObject()

            if let index = tmpArray!.firstIndex(where: { $0 == fileObject }) {
                tmpArray?.remove(at: index)
                let data = self.encodeObject(tmpArray!)
                self.setUserDefault(data)
            }
        }
    }

    private func modifiedFavoriteData(_ fileObject: FileObject) {
        var tmpArray: [FileObject]?
        tmpArray = self.decodeObject()
        tmpArray?.append(fileObject)

        let data = self.encodeObject(tmpArray!)
        self.setUserDefault(data)
    }

    private func decodeObject() -> [FileObject] {
        if let storeData = userDefault!.data(forKey: storeKey) {
            //let encodeObject = NSKeyedUnarchiver.unarchiveObject(with: storeData) as! [RadioStation]
            let encodeObject = try? PropertyListDecoder().decode([FileObject].self, from: storeData) //TODO
            return encodeObject!
        } else {
            return [FileObject]()
        }
    }

    private func encodeObject(_ data: Any) -> Data {
        //let data = NSKeyedArchiver.archivedData(withRootObject: data)
        let data = try? PropertyListEncoder().encode(data as! [FileObject])
        return data!
    }
    
    private func setUserDefault(_ data: Data) {
        userDefault!.set(data, forKey: storeKey)
        userDefault!.synchronize()
    }
}
