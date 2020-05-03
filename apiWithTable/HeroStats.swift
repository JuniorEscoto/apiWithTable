//
//  HeroStats.swift
//  apiWithTable
//
//  Created by junior on 4/28/20.
//  Copyright © 2020 junior. All rights reserved.
//

import Foundation

// este es como el modelo, en otras parte va dentro de una carpeta models

struct Question: Codable {
    let name: String // The prompt/title/question we want to as
    let img: String
    let localized_name : String
}



