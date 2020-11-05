//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import SwiftUI
import SwiftUIImagePickerController

struct ContentView: View {
//    @Binding var document: PackageDocSwiftUIDocument
    @ObservedObject var viewModel: NoteViewModel
    
    init(document: Binding<PackageDocSwiftUIDocument>) {
        self.viewModel = NoteViewModel(doc: document)
    }

    var body: some View {
        VStack {
            TextPartView(text: $viewModel.document.note.notes)
                .frame(width: UIScreen.main.bounds.width, height: 200)
            ImagePartView(image: $viewModel.document.note.image)
                .frame(width: UIScreen.main.bounds.width, height: 200)
        }
    }
}

struct TextPartView: View {
    @Binding var text: String
    var body: some View {
        TextEditor(text: $text)
            .border(Color.gray)
            .ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct ImagePartView: View {
    @Binding var image: UIImage?
    @State private var metaData:NSDictionary? = nil
    @State private var showPhotoPicker = false
    var body: some View {
        Group {
            if (image == nil) {
                Text("no Image")
                    .border(Color.gray)

                    .onTapGesture {
                        showPhotoPicker.toggle()
                    }
            } else {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        showPhotoPicker.toggle()
                    }
            }
        }
        .fullScreenCover(isPresented: $showPhotoPicker) {
            SwiftUIImagePickerController(image: $image, metaData: $metaData, showCameraView: $showPhotoPicker)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(PackageDocSwiftUIDocument()))
    }
}
