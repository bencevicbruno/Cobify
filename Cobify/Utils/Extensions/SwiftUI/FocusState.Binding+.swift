//
//  FocusState.Binding+.swift
//  Cobify
//
//  Created by Bruno Bencevic on 30.11.2022..
//

import SwiftUI

extension FocusState.Binding where Value == Bool {
    
    var asBoolBinding: Binding<Bool> {
        .init(get: {
            return self.wrappedValue
        }, set: { newValue in
            self.wrappedValue = newValue
        })
    }
}
