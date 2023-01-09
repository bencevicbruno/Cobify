//
//  SongView.swift
//  Cobify
//
//  Created by Bruno Bencevic on 18.11.2022..
//

import SwiftUI

struct PlayingSong: Identifiable {
    let model: SongModel
    let source: SongSource?
    
    var id: Int {
        model.id
    }
}

enum SongSource {
    case favorites
    case suggested
    case playlist(name: String)
    
    var title: String {
        switch self {
        case .favorites:
            return "favorites"
        case .suggested:
            return "suggested"
        case .playlist(let name):
            return name
        }
    }
}

struct SongView: View {
    
    @StateObject var viewModel: SongViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(song: PlayingSong) {
        self._viewModel = .init(wrappedValue: .init(song: song))
    }
    
    var body: some View {
        VStack {
            navigationBar
            
            songImage
                .padding(20)
            
            songDetails
            
            SongSlider(progress: $viewModel.progress)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
            
            Spacer()
            
            controlButtons
            
            Spacer()
        }
        .padding(12)
        .background(
            backgroundFrost
        )
        .foregroundColor(Color.cobifyPlatinum)
        .onChange(of: viewModel.progress) { progress in
            if progress >= 1.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    dismiss()
                }
            }
        }
    }
    
    var backgroundFrost: some View {
        OnlineImage(songID: viewModel.song.id, imageURL: viewModel.song.model.imageURL) { image in
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .overlay(BlurredView(style: .light))
                .overlay(.black.opacity(0.4))
                .ignoresSafeArea(.all)
        } placeholder: {
            Color.cobifyOnyx
                .ignoresSafeArea(.all)
        }
    }
    
    var navigationBar: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(systemName: "chevron.down")
                .resizable()
                .scaledToFit()
                .frame(size: 24)
                .frame(size: 40)
                .contentShape(Rectangle())
                .onTapGesture {
                    dismiss()
                }
            
            Spacer(minLength: 12)
            
            if let source = viewModel.song.source {
                VStack(spacing: 0) {
                    Text("PLAYING FROM")
                        .font(.subheadline)
                    
                    Text(source.title.uppercased())
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            
            Spacer(minLength: 12)
            
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(size: 24)
                .frame(size: 40)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.isFavorite.toggle()
                }
                .shadow(color: viewModel.isFavorite ? .white : .clear, radius: 10)
        }
        .frame(height: 60)
        .shadow(radius: 10)
    }
    
    var songDetails: some View {
        VStack(spacing: 0) {
            Text(viewModel.song.model.title)
                .fontWeight(.bold)
            
            Text(viewModel.song.model.artist)
        }
        .shadow(radius: 10)
    }
    
    var songImage: some View {
        OnlineImage(songID: viewModel.song.id, imageURL: viewModel.song.model.imageURL) { image in
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(size: UIScreen.width - 2 * 32)
        } placeholder: {
            Color.cobifyPlatinum
                .overlay {
                    ProgressView()
                }
        }
        .background(Color.cobifyAlabaster)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .aspectRatio(1, contentMode: .fit)
        .shadow(radius: 15)
    }
    
    var controlButtons: some View {
        HStack {
            Spacer()
            
            Image(systemName: "backward.end")
                .resizable()
                .scaledToFit()
                .frame(size: 40)
                .isHidden(true)
            
            Spacer()
            
            Icon(!viewModel.isPlaying ? "play.fill" : "pause", iconSize: 40, frameSize: 40) {
                withAnimation {
                    viewModel.isPlaying.toggle()
                }
            }
            
            Spacer()
            
            Image(systemName: "forward.end")
                .resizable()
                .scaledToFit()
                .frame(size: 40)
                .isHidden(true)
            
            Spacer()
        }
        .shadow(radius: 10)
    }
}

struct SongView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var isFavorite = true
        
        return SongView(song: .init(model: .sample, source: nil))
    }
}
