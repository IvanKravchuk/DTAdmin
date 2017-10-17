//
//  Entities.swift
//  DTAdmin
//
//  Created by Admin on 18.10.17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import Foundation

struct Group: Decodable, Encodable {
    let group_id: String
    let group_name: String
    let faculty_id: String
    let speciality_id: String
}

struct Faculty: Decodable, Encodable {
    let faculty_id: String
    let faculty_name: String
    let faculty_description: String
}

struct Speciality: Decodable, Encodable {
    let speciality_id: String
    let speciality_code: String
    let speciality_name: String
}
