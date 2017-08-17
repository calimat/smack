//
//  Channel.swift
//  smack
//
//  Created by Ricardo Herrera Petit on 8/16/17.
//  Copyright © 2017 Ricardo Herrera Petit. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v:Int?
}
