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
        VStack {
            TextPartView(text: $document.note.notes)
                .frame(width: 300, height: 300)
            ImagePartView(image: $document.note.image)
                .frame(width: 300, height: 300)
        }

        //TextEditor(text: $document.text)
    }
}

struct TextPartView: View {
    @Binding var text: String
    var body: some View {
        TextEditor(text: $text)
    }
}

struct ImagePartView: View {
    @Binding var image: UIImage?
    var body: some View {
        if (image == nil) {
            Text("no Image")
        } else {
            Image(uiImage: image!)
                .resizable()
                .scaledToFit()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(PackageDocSwiftUIDocument()))
    }
}
