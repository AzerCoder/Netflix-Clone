//
//  YoutubeSearchResponse.swift
//  Netflix
//
//  Created by A'zamjon Abdumuxtorov on 07/10/24.
//

import Foundation


struct YoutubeSearchResponse:Codable{
    let items: [VideoElement]
}

struct VideoElement:Codable{
    let id: IdVideoElement
}

struct IdVideoElement:Codable{
    let kind:String
    let videoId:String
}
