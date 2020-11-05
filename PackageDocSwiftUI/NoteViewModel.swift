//
//  NoteViewModel.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import Foundation
import SwiftUI

class NoteViewModel: ObservableObject {
//    let note: Note
//    @Published var note: Note
    @Binding var noteDoc: PackageDocSwiftUIDocument
    
    init(noteDoc: Binding<PackageDocSwiftUIDocument>){
//        init(note: Note) {
        self._noteDoc = noteDoc
//        self.note = note
    }
    
    var noteString: String {
        get {
            return noteDoc.noteString
        }
        set {
            print("set \(newValue)")
            noteDoc.noteString = newValue
        }
    }

    var image: UIImage? {
        get {
            if let image = noteDoc.image {
                return image
            }
            let largeConfig = UIImage.SymbolConfiguration(scale: .large)
            return UIImage(systemName: "power", withConfiguration: largeConfig)!
        }
        set {
            noteDoc.image = newValue
        }
    }
    

}
