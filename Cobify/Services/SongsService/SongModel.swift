//
//  SongModel.swift
//  Cobify
//
//  Created by Bruno Bencevic on 29.11.2022..
//

import Foundation

struct SongModel: Identifiable, Decodable {
    let id: Int
    let title: String
    let artist: String
    let duration: Int
    let imageURL: String
    let audioURL: String
    
    init(id: Int, title: String, artist: String, duration: Int, imageURL: String = "", audioURL: String = "") {
        self.id = id
        self.title = title
        self.artist = artist
        self.duration = duration
        self.imageURL = imageURL
        self.audioURL = audioURL
    }
    
    init(from response: SongResponse) {
        self.id = response.id
        self.title = response.songName
        self.artist = response.artist
        self.duration = 500
        self.imageURL = response.imageURL
        self.audioURL = response.songURL
    }
    
    var formattedDuration: String {
        let minutes = duration / 60
        let seconds = duration % 60
        
        if minutes > 99 {
            return "forever"
        }
        
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutesString):\(secondsString)"
    }
}

extension SongModel {
    
    static var sample: SongModel {
        .init(id: 0, title: "Sample Song", artist: "Some Singer", duration: 555, imageURL: "https://cdn.drawception.com/images/panels/2012/4-11/Lgc5yt99eb-4.png")
    }
}

extension Array where Element == SongModel {
    
    static var samples: Self {[
        .sample,
        .init(id: 1, title: "Amazing Art", artist: "Awesome Artist", duration: 444, imageURL: "https://static.wikia.nocookie.net/characterprofile/images/7/75/Spongebob_Squarepants_-_2022-10-03T192210.178.png/revision/latest/scale-to-width-down/444?cb=20221004022245"),
        .init(id: 2, title: "Brutal Bass", artist: "Bassist Bruno", duration: 333, imageURL: "https://nick-intl.mtvnimages.com/uri/mgid:file:gsp:kids-assets:/nick/properties/spongebob-squarepants/characters/mrkrabs-character-web-desktop.png?height=0&width=480&matte=true&crop=false"),
        .init(id: 3, title: "Catastrophic Chellos", artist: "Catalysm", duration: 222, imageURL: "https://miro.medium.com/max/1024/0*YjYX05Vdd6K8UOY8.png"),
        .init(id: 4, title: "Dancing Donkey", artist: "Dark D", duration: 111, imageURL: "https://nick-intl.mtvnimages.com/uri/mgid:file:gsp:kids-assets:/nick/properties/spongebob-squarepants/characters/sandy-character-web-desktop.png?height=0&width=480&matte=true&crop=false")
    ]}
    
}
