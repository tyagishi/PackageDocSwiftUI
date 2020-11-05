//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/05
//  © 2020  SmallDeskSoftware
//

import SwiftUI
import SwiftUIImagePickerController

struct ContentView: View {
    @ObservedObject var viewModel: NoteViewModel
    
    var body: some View {
        VStack {
            DocumentTextView(text: $viewModel.noteString)
                .frame(width: UIScreen.main.bounds.width, height: 200)
            DocumentImageView(image: $viewModel.image)
                .frame(width: UIScreen.main.bounds.width, height: 200)
        }
    }
}

struct DocumentTextView: View {
    @Binding var text: String
    var body: some View {
        TextEditor(text: $text)
            .border(Color.gray)
            .ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct DocumentImageView: View {
    @Binding var image: UIImage?
    @State private var metaData:NSDictionary? = nil
    @State private var showPhotoPicker = false
    var body: some View {
        Group {
            Image(uiImage:  image!)
                .resizable()
                .scaledToFit()
                .border(Color.gray)
                .onTapGesture {
                    showPhotoPicker.toggle()
                }
        }
        .fullScreenCover(isPresented: $showPhotoPicker) {
            SwiftUIImagePickerController(image: $image, metaData: $metaData, showCameraView: $showPhotoPicker)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: NoteViewModel(noteDoc: .constant(PackageDocSwiftUIDocument())))
    }
}
