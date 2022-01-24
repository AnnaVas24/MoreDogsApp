//
//  Dogs.swift
//  MoreDogsApp
//
//  Created by Vasichko Anna on 22.01.2022.
//

import Foundation

let dogsApi = "https://dog.ceo/api/breeds/image/random/20"

struct Dogs: Decodable {
    let message: [String]
    let status: String
}
