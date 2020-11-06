//
//  DocumentViewModel.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import Foundation
import SwiftUI

class DocumentViewModel: ObservableObject {
    @Binding var noteDoc: PackageDocSwiftUIDocument
    
    init(noteDoc: Binding<PackageDocSwiftUIDocument>){
        self._noteDoc = noteDoc
    }
    
    var noteString: String {
        get {
            return noteDoc.noteString
        }
        set {
            noteDoc.noteString = newValue
        }
    }

    var image: UIImage? {
        get {
            if let image = noteDoc.image {
                return image
            }
            return UIImage(systemName: "nosign")
        }
        set {
            noteDoc.image = newValue
        }
    }
}
