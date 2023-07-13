//
//  ContentView.swift
//  macOSTest
//
//  Created by 한지석 on 2023/07/11.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//
    @ObservedObject var viewModel = CloudManager()
    @State var text: String = ""

    var body: some View {
        NavigationView {
            ListView()
            MemoView(text: $text, viewModel: viewModel)
        }
    }
}

struct ListView: View {
    var body: some View {
        VStack {
            Text("List")
        }
    }
}

struct MemoView: View {
    
    @Binding var text: String
    @ObservedObject var viewModel: CloudManager
    
    var body: some View {
        VStack {
            Text("How to custom macOS App")
                .foregroundColor(.indigo)
                .background(.orange)
            TextEditor(text: $text)
//                .onReceive(Just(text)) { newValue in
//                    print("new - \(newValue)")
//                }
//                .onSubmit {
//                    print("Hi")
//                    print("submit - \($text)")
//                }
                .font(Font.system(size: 15))
            Spacer()
            Button {
                viewModel.fetchMemo()
            } label: {
                Text("Button")
                    .foregroundColor(.accentColor)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
