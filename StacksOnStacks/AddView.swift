//
//  AddView.swift
//  StacksOnStacks
//
//  Created by Jason Cusack on 03/30/2021.
//  Copyright © 2021 CuSoft. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var description = ""
    @State private var rating = "Grade"
    let ratings = ["S", "A", "B", "C"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Crypto Name", text: $name)
                    TextField("Description", text: $description)

                    Picker("Rating", selection: $rating) {
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating)
                        }
                    }
                }

                Button("Add Crypto") {
                    let newCrypto = Crypto(context: self.moc)
                    newCrypto.name = self.name
                    newCrypto.description = self.description
                    newCrypto.rating = self.rating

                    do {
                        try self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Whoops! \(error.localizedDescription)")
                    }
                }
            }.navigationBarTitle("New Crypto")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
