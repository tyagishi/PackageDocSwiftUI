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
    
    var note: Note

    init() {
        self.note = Note(notes: "", image: nil)
    }

    static var readableContentTypes: [UTType] { [.notesDoc] }

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

        self.note = Note(notes: string, image: image)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let docWrapper = FileWrapper.init(directoryWithFileWrappers: [String:FileWrapper]())
        
        guard let textData = note.notes.data(using: .utf8) else { fatalError("failed to get text data") }
        let noteWrapper = FileWrapper.init(regularFileWithContents: textData)
        noteWrapper.preferredFilename = PackageDocSwiftUIDocument.textFileName
        docWrapper.addFileWrapper(noteWrapper)

        if note.image != nil {
            guard let imageData = note.image?.pngData() else { fatalError("failed to get png data") }
            let imageWrapper = FileWrapper.init(regularFileWithContents: imageData)
            imageWrapper.preferredFilename = PackageDocSwiftUIDocument.imageFileName
            docWrapper.addFileWrapper(imageWrapper)
        }

        return docWrapper
    }
}
