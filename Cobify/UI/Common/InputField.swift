//
//  InputField.swift
//  Cobify
//
//  Created by Bruno Bencevic on 16.11.2022..
//

import SwiftUI

struct InputField: View {
    
    private let name: String
    @Binding private var text: String
    @FocusState private var fieldFocus: Bool
    private var showError: Bool
    
    @State private var isFocused: Bool
    
    
    init(name: String, text: Binding<String>, isInFocus: FocusState<Bool>, showError: Bool) {
        self.name = name
        self._text = text
        self._fieldFocus = isInFocus
        self.showError = showError
        
        self.isFocused = isInFocus.wrappedValue
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextField("", text: $text)
                .focused($fieldFocus)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .frame(height: 60)
                .background(
                    BlurredView(style: .light)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(borderColor, lineWidth: 2)
                            
                        }
                )
                .padding(.top, 12)
            
            HStack(spacing: 0) {
                Text(name)
                    .foregroundColor(titleColor)
                    .fontWeight(titleFontWeight)
                
                Text("*")
                    .foregroundColor(.red)
                    .fontWeight(titleFontWeight)
                    .isVisible(showError && isFocused)
            }
            .padding(.horizontal, titleHorizontalPadding)
            .background(.white)
            .padding(.top, titleOffset.height)
            .padding(.leading, titleOffset.width)
            .allowsHitTesting(false)
        }
        .onTapGesture {
            fieldFocus = true
        }
        .onChange(of: fieldFocus) { _ in
            handleFocus()
        }
        .onChange(of: text) { _ in
            handleFocus()
        }
    }
    
    func handleFocus() {
        withAnimation {
            isFocused = fieldFocus || !text.isEmpty
        }
    }
}

private extension InputField {
    
    var titleOffset: CGSize {
        isFocused ? .init(width: 12, height: 0) : .init(width: 24, height: 32)
    }
    
    var titleColor: Color {
        if isFocused && showError {
            return .red
        } else {
            return isFocused ? Color.cobifySunray : .gray
        }
    }
    
    var borderColor: Color {
        showError ? .red : Color.cobifySunray
    }
    
    var titleFontWeight: Font.Weight {
        isFocused ? .bold : .regular
    }
    
    var titleHorizontalPadding: CGFloat {
        isFocused ? 6 : 0
    }
}

struct InputField_Previews: PreviewProvider {
    
    static var previews: some View {
        @FocusState var isInFocus
        @State var text = ""
        
        return InputField(name: "Example", text: $text, isInFocus: _isInFocus, showError: .random())
            .padding()
    }
}
