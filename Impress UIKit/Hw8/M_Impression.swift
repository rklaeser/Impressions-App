//
//  Data.swift
//  Hw8
//
//  Created by Reed Klaeser on 3/4/24.
//

import Foundation

class M_Impression {
    
    enum `Type`: String {
        case Movie = "Movie"
        case Star = "Star"
        case President = "President"

    }
    enum `Generation`: String, CaseIterable {
        case All = "No Filter"
        case M = "Millenial"
        case Fogey = "Fogey"

    }
    
    var name: String
    var type: Type
    var subtitle: String
    var script: String
    var complete: Bool
    var imageName: String
    var gen: Int
    init(name: String, type: Type, subtitle: String,
         script: String, complete: Bool, imageName: String, gen: Int) {
        self.name = name
        self.type = type
        self.subtitle = subtitle
        self.script = script
        self.complete = complete
        self.imageName = imageName
        self.gen = gen
    }
}

let M_Impressions = [
    M_Impression(name: "Arnold", type: .Movie, subtitle: "I'll be back", script: "I'll be back", complete: true, imageName: "Arnold", gen: 0),
    M_Impression(name: "Vizzini", type: .Movie, subtitle: "Inconceivable", script: "Inconceivable", complete: false, imageName: "Vizzini", gen: 1),
    M_Impression(name: "Don Corleone", type: .Movie, subtitle: "On the day", script: "But uh, now you come to me and you say -- \"Don Corleone give me justice.\" -- But you don't ask with respect. You don't offer friendship. You don't even think to call me Godfather. Instead, you come into my house on the day my daughter is to be married, and you uh ask me to do murder, for money.", complete: false, imageName: "Don", gen: 0),
    M_Impression(name: "Scarlett O'Hara", type: .Movie, subtitle: "Southern Accent", script: "As God is my witness, I'll never be hungry again.", complete: false, imageName: "Scarlett", gen: 2),
    M_Impression(name: "Forrest Gump", type: .Movie, subtitle: "Stutter", script: "My mama always said life was like a box of chocolates. You never know what you're gonna get.", complete: false, imageName: "Forrest" , gen: 0),
    M_Impression(name: "Mathew McConaughey", type: .Star, subtitle: "Man", script: "Alright, alright, alright. Let me tell ya, life's like a quadratic equation - full of ups and downs, but you gotta stay positive, keep solving those problems, and eventually, you'll find the solution right there in front of ya. Just gotta keep livin', man, keep livin'", complete: false, imageName: "Mathew", gen: 1),
    M_Impression(name: "Marilyn Monroe", type: .Star, subtitle: "Diamonds Are a Girl's Best Friend", script: "A kiss on the hand may be quite continental, but diamonds are a girl's best friend.", complete: false, imageName: "Marilyn", gen: 2),
    M_Impression(name: "Charlie Chaplin", type: .Star, subtitle: "Pantomiming", script: "You, the people, have the power to make this life free and beautiful, to make this life a wonderful adventure.", complete: false, imageName: "Charlie", gen: 2),
    M_Impression(name: "Jack Nicholson", type: .Star, subtitle: "Here's Johnny", script: "Well, here's Johnny! You want the truth? You can't handle the truth! Let me tell ya something, dollface, this world's a crazy place, but you gotta embrace the madness", complete: false, imageName: "Jack", gen: 0),
    M_Impression(name: "Trump", type: .President, subtitle: "Believe Me", script: "Listen folks, let me tell you, I've got the best words, believe me. We're gonna make America great again, big league. Nobody builds walls better than me, believe me.", complete: false, imageName: "Trump", gen: 0),
    M_Impression(name: "Biden", type: .President, subtitle: "Look here", script: "Folks, let me be clear. It's time to build back better. We're facing some tough challenges, but we're Americans, we don't cower, we confront. We're gonna unite this country, heal the soul of our nation. Look, here's the deal: we're gonna work together, Democrats and Republicans, to get things done.", complete: false, imageName: "Biden", gen: 0),
    M_Impression(name: "Obama", type: .President, subtitle: "Let me be clear", script: "My fellow Americans, let me be clear. Change doesn't come easy, but it is possible. Yes, we can. We've made great strides, but our journey is far from over.", complete: false, imageName: "Obama", gen: 0),
    M_Impression(name: "George W. Bush", type: .President, subtitle: "Now watch this drive", script: "I call upon all nations to do everything they can to stop these terrorist killers. Thank you. Now, watch this drive.", complete: false, imageName: "Bush", gen: 0)
]

