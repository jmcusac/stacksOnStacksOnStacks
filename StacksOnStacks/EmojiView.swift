//
//  EmojiView.swift
//  StacksOnStacks
//
//  Created by Jason Cusack on 03/30/2021.
//  Copyright © 2021 CuSoft. All rights reserved.
//

import SwiftUI

struct EmojiView: View {
    var rating: String

    var body: some View {
        switch rating {
        case "S":
            return Text("😏")
        case "A":
            return Text("😐")
        case "B":
            return Text("😔")
        default:
            return Text("😭")
        }
    }

    init(for rating: String) {
        self.rating = rating
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(for: "S")
    }
}
