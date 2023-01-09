//
//  PlaylistCell.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import SwiftUI

struct PlaylistCell: View {
    
    var body: some View {
        HStack(spacing: 12) {
            playlistCollage
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Evergreens")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("12 songs")
                    .font(.body)
                    .fontWeight(.semibold)
                
                Text("1:23")
                    .font(.body)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            Icon("ellipsis")
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.trailing, 8)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .frame(height: 92)
        .background(Color.cobifyPlatinum)
        .foregroundColor(Color.cobifyOnyx)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(RoundedRectangle(cornerRadius: 16))
    }
}

private extension PlaylistCell {
    
    var playlistCollage: some View {
        Image("placeholder_panda")
            .resizable()
            .scaledToFill()
    }
}

struct PlaylistCell_Previews: PreviewProvider {
    
    static var previews: some View {
        PlaylistCell()
    }
}
