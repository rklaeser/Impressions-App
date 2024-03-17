//
//  Data.swift
//  Hw8
//
//  Created by Reed Klaeser on 3/4/24.
//

import Foundation

struct M_Social : Hashable {
    
    var videoName: String
    var userName: String
    var caption: String
    init(_videoName: String, _userName: String, _caption: String) {
        self.videoName = _videoName
        self.userName = _userName
        self.caption = _caption
    }
}

var M_Socials = [
    M_Social(_videoName: "Kona", _userName: "@KonaTheDog", _caption: "dogs need treats ❤️"),
    M_Social(_videoName: "Kona", _userName: "@KonaTheDog", _caption: "dogs need treats ❤️")
]



