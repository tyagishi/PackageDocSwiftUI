//
//  PackageDocSwiftUIDocument.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var notesDoc: UTType {
        UTType(exportedAs: "com.apple.dts.notesDoc")
    }
}

struct PackageDocSwiftUIDocument: FileDocument {
    static let textFileName: String = "Text.txt"
    static let imageFileName: String = "Image.png"
    
    var noteString: String = ""
    var image: UIImage? = nil

    static var readableContentTypes: [UTType] { [.notesDoc] }

    init() {
        noteString = ""
        image = nil
    }
    
    init(configuration: ReadConfiguration) throws {
        let docWrapper = configuration.file
        
        guard let noteWrapper = docWrapper.fileWrappers![PackageDocSwiftUIDocument.textFileName] else { fatalError("failed to get notewrapper") }
        guard let textData = noteWrapper.regularFileContents else { fatalError("failed to get text data") }
        guard let string = String.init(data: textData, encoding: .utf8) else { fatalError("failed to unarchive text data") }

        var image: UIImage? = nil
        if let imageWrapper = docWrapper.fileWrappers![PackageDocSwiftUIDocument.imageFileName] {
            guard let imageData = imageWrapper.regularFileContents else { fatalError("failed to get image data") }
            image = UIImage(data: imageData)
        }
        self.noteString = string
        self.image = image
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        print("----- save -----")
        let docWrapper = FileWrapper.init(directoryWithFileWrappers: [String:FileWrapper]())
        
        guard let textData = noteString.data(using: .utf8) else { fatalError("failed to get text data") }
        let noteWrapper = FileWrapper.init(regularFileWithContents: textData)
        noteWrapper.preferredFilename = PackageDocSwiftUIDocument.textFileName
        docWrapper.addFileWrapper(noteWrapper)

        if let image = self.image {
            guard let imageData = image.pngData() else { fatalError("failed to get png data") }
            let imageWrapper = FileWrapper.init(regularFileWithContents: imageData)
            imageWrapper.preferredFilename = PackageDocSwiftUIDocument.imageFileName
            docWrapper.addFileWrapper(imageWrapper)
        }

        return docWrapper
    }
}
