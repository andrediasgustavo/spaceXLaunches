//
//  SpaceXLaunchesModel.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import Foundation

import Foundation

// MARK: - SpaceXLaunchModelElement
public struct SpaceXLaunchModel: Codable {
    let flightNumber: Int
    let missionName: String
    let links: Links?
    let launchDateUTC: String
    let rocket: Rocket?

    enum CodingKeys: String, CodingKey {
        case links, rocket
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDateUTC = "launch_date_utc"
    }
}

// MARK: - Links
struct Links: Codable {
    let missionPatch: String?
    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
    }
}

// MARK: - Rocket
struct Rocket: Codable {
    let rocketID: String?
    let rocketName: String?
    let rocketType: String?

    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}
