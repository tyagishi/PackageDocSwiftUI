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
    @Binding var document:PackageDocSwiftUIDocument

    var editableString: String {
        get {
            return document.note.notes
        }
        set {
            document.note.notes = newValue
        }
    }
    
    var displayImage: UIImage {
        get {
            if let image = document.note.image {
                return image
            }
            return UIImage(systemName: "nosign")!
        }
        set {
            document.note.image = newValue
        }
    }
    
    init(doc: Binding<PackageDocSwiftUIDocument>) {
        self._document = doc
    }
    
}
