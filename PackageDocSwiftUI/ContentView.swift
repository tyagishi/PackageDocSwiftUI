//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import SwiftUI

struct ContentView: View {
    @Binding var document: PackageDocSwiftUIDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(PackageDocSwiftUIDocument()))
    }
}
