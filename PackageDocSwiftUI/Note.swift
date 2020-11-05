//
//  Note.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import Foundation
import UIKit

class Note: ObservableObject, Identifiable {
    var notes: String
    var image: UIImage?
    
    init(notes: String, image:UIImage?) {
        self.notes = notes
        self.image = image
    }
}
