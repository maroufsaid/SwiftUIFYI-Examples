//
//  SaveToFiles.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 18.10.24.
//

import SwiftUI

// inspired by https://stackoverflow.com/questions/39103095/unnotificationattachment-with-uiimage-or-remote-url

extension Image {
    static func create(identifier: String, image: UIImage, options: [NSObject : AnyObject]?) -> URL? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            let imageFileIdentifier = identifier+".png"
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            let imageData = UIImage.pngData(image)
            try imageData()?.write(to: fileURL)
            return fileURL
        } catch {
            print("error " + error.localizedDescription)
        }
        return nil
    }
}

struct SaveToFilesView: View {
    
    var body: some View {
        VStack {
            
            let url = Image.create(
                identifier: "uniqueImageName",
                // image inside Assets.xcassets
                image: UIImage(named: "background2")!,
                options: nil
            )
            let _ = print(url!)
            
            ShareLink(
                item: url!, message: Text("Hello")
            )
            
            
        }
    }
}
