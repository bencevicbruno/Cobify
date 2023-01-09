//
//  RecommendedSongCell.swift
//  Cobify
//
//  Created by Bruno Bencevic on 28.11.2022..
//

import SwiftUI

struct RecommendedSongCell: View {
    
    let model: SongModel
    @Binding var isFavorite: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            OnlineImage(songID: model.id, imageURL: model.imageURL) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.cobifyAlabaster
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(size: 80)
            .background(Color.cobifyAlabaster)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(model.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(model.artist)
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            Icon(isFavorite ? "heart.fill" : "heart") {
                isFavorite.toggle()
            }
            .padding(.trailing, 8)
        }
        .padding(12)
        .frame(maxWidth: .infinity, height: 92)
        .background(Color.cobifyPlatinum)
        .foregroundColor(Color.cobifyOnyx)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct RecommendedSongCell_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            RecommendedSongCell(model: .sample, isFavorite: .constant(false))
            
            RecommendedSongCell(model: .sample, isFavorite: .constant(true))
        }
        .padding()
    }
}
