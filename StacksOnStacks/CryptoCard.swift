//
//  CryptoCard.swift
//  StacksOnStacks
//
//  Created by Jason Cusack on 03/30/2021.
//  Copyright © 2021 CuSoft. All rights reserved.
//

import CoreData
import SwiftUI

struct CryptoCard: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingDescription = false
    @State private var randomNumber = Int.random(in: 0...9)
    @State private var dragAmount = CGSize.zero
    var crypto: Crypto

    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    Image("\(self.randomNumber)")
                        .resizable()
                        .frame(width: 300, height: 100)

                    Text(self.crypto.name)
                        .font(.largeTitle)
                        .lineLimit(10)
                        .padding([.horizontal])

                    Text(self.crypto.info)
                        .font(.headline)
                        .lineLimit(10)
                        .padding([.horizontal, .bottom])
                        .blur(radius: self.showingDescription ? 0 : 6)
                        .opacity(self.showingDescription ? 1 : 0.25)
                }
                .multilineTextAlignment(.center)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: .black, radius: 5, x: 0, y: 0)
                )
                .onTapGesture {
                    withAnimation {
                        self.showingDescription.toggle()
                    }
                }
                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 10), axis: (x: 0, y: 1, z: 0))
            }

            EmojiView(for: crypto.rating)
                .font(.system(size: 72))
        }
        .frame(minHeight: 0, maxHeight: .infinity)
        .frame(width: 300)
        .offset(y: dragAmount.height)
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { value in
                    if self.dragAmount.height < -200 {
                        withAnimation {
                            self.dragAmount = CGSize(width: 0, height: -1000)

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                self.moc.delete(self.crypto)
                                // try? self.moc.save()
                            }
                        }
                    } else {
                        self.dragAmount = .zero
                    }
                }
        )
        .animation(.spring())
    }
}

struct CryptoCard_Previews: PreviewProvider {
    static var previews: some View {
        let crypto = Crypto(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        crypto.name = "BCH ABC"
        crypto.info = "BitCoin Cash ABC"
        crypto.rating = "A"

        return CryptoCard(crypto: crypto)
    }
}
