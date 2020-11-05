//
//  PackageDocSwiftUIApp.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import SwiftUI

@main
struct PackageDocSwiftUIApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: PackageDocSwiftUIDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
