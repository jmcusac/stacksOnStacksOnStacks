//
//  ContentView.swift
//  StacksOnStacks
//
//  Created by Jason Cusack on 03/30/2021.
//  Copyright © 2021 CuSoft. All rights reserved.
//

import SwiftUI

// This was our original ContentView, using List and NavigationView
struct OldContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Crypto.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Crypto.name, ascending: true)
    ]) var cryptos: FetchedResults<Crypto>
    @State var showingAddCrypto = false

    var body: some View {
        NavigationView {
            List {
                ForEach(cryptos, id: \.name) { crypto in
                    NavigationLink(destination: Text(crypto.description)) {
                        EmojiView(for: crypto.rating)
                        Text(crypto.name)
                    }
                }.onDelete(perform: removeCryptos)
            }
            .navigationBarTitle("Block Chains & Coins")
            .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
                self.showingAddCrypto.toggle()
            })
        }
        .sheet(isPresented: $showingAddCrypto) {
            AddView().environment(\.managedObjectContext, self.moc)
        }
    }

    func removeCryptos(at offsets: IndexSet) {
        for index in offsets {
            let crypto = cryptos[index]
            moc.delete(crypto)
        }

        try? moc.save()
    }
}

// This is the newer ContentView, using a scroll view, gestures, and rotating cards
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Crypto.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Crypto.name, ascending: true)
    ]) var cryptos: FetchedResults<Crypto>
    @State private var showingAddCrypto = false

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient: Gradient(colors: [Color("Start"), Color("Middle"), Color("End")]), startPoint: .top, endPoint: .bottom)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(cryptos, id: \.name) { crypto in
                        CryptoCard(crypto: crypto)
                    }
                }.padding()
            }

            Button("Add Crypto") {
                self.showingAddCrypto.toggle()
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .clipShape(Capsule())
            .foregroundColor(.white)
            .offset(y: 50)
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showingAddCrypto) {
            AddView().environment(\.managedObjectContext, self.moc)
        }
    }

    func removeCryptos(at offsets: IndexSet) {
        for index in offsets {
            let crypto = cryptos[index]
            moc.delete(crypto)
        }

        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
