//
//  Company.swift
//  UrveshMishraTask
//
//  Created by Urvesh Mishra on 26/08/22.
//

/*import Foundation

// MARK: - Company
struct Company: Codable {
    let headquarters: Headquarters
    let links: Links
    let name, founder: String
    let founded, employees, vehicles, launch_sites: Int
    let test_sites: Int
    let ceo, cto, coo, cto_propulsion: String
    let valuation: Int
    let summary, id: String
    
}

// MARK: - Headquarters
struct Headquarters: Codable {
    let address, city, state: String
}

// MARK: - Links
struct Links: Codable {
    let website, flickr, twitter, elon_twitter: String
    let webcast: String
        let youtubeID: String
        let article: String
        let wikipedia: String
    
}
*/

//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation

struct Company: Codable {

    let headquarters: Headquarters
    let links: Links
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let vehicles: Int
    let launchSites: Int
    let testSites: Int
    let ceo: String
    let cto: String
    let coo: String
    let ctoPropulsion: String
    let valuation: Int
    let summary: String
    let id: String

    private enum CodingKeys: String, CodingKey {
        case headquarters = "headquarters"
        case links = "links"
        case name = "name"
        case founder = "founder"
        case founded = "founded"
        case employees = "employees"
        case vehicles = "vehicles"
        case launchSites = "launch_sites"
        case testSites = "test_sites"
        case ceo = "ceo"
        case cto = "cto"
        case coo = "coo"
        case ctoPropulsion = "cto_propulsion"
        case valuation = "valuation"
        case summary = "summary"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headquarters = try values.decode(Headquarters.self, forKey: .headquarters)
        links = try values.decode(Links.self, forKey: .links)
        name = try values.decode(String.self, forKey: .name)
        founder = try values.decode(String.self, forKey: .founder)
        founded = try values.decode(Int.self, forKey: .founded)
        employees = try values.decode(Int.self, forKey: .employees)
        vehicles = try values.decode(Int.self, forKey: .vehicles)
        launchSites = try values.decode(Int.self, forKey: .launchSites)
        testSites = try values.decode(Int.self, forKey: .testSites)
        ceo = try values.decode(String.self, forKey: .ceo)
        cto = try values.decode(String.self, forKey: .cto)
        coo = try values.decode(String.self, forKey: .coo)
        ctoPropulsion = try values.decode(String.self, forKey: .ctoPropulsion)
        valuation = try values.decode(Int.self, forKey: .valuation)
        summary = try values.decode(String.self, forKey: .summary)
        id = try values.decode(String.self, forKey: .id)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headquarters, forKey: .headquarters)
        try container.encode(links, forKey: .links)
        try container.encode(name, forKey: .name)
        try container.encode(founder, forKey: .founder)
        try container.encode(founded, forKey: .founded)
        try container.encode(employees, forKey: .employees)
        try container.encode(vehicles, forKey: .vehicles)
        try container.encode(launchSites, forKey: .launchSites)
        try container.encode(testSites, forKey: .testSites)
        try container.encode(ceo, forKey: .ceo)
        try container.encode(cto, forKey: .cto)
        try container.encode(coo, forKey: .coo)
        try container.encode(ctoPropulsion, forKey: .ctoPropulsion)
        try container.encode(valuation, forKey: .valuation)
        try container.encode(summary, forKey: .summary)
        try container.encode(id, forKey: .id)
    }

}

struct Headquarters: Codable {

    let address: String
    let city: String
    let state: String

    private enum CodingKeys: String, CodingKey {
        case address = "address"
        case city = "city"
        case state = "state"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decode(String.self, forKey: .address)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .state)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
    }

}

struct Links: Codable {

    let website: String
    let flickr: String
    let twitter: String
    let elonTwitter: String

    private enum CodingKeys: String, CodingKey {
        case website = "website"
        case flickr = "flickr"
        case twitter = "twitter"
        case elonTwitter = "elon_twitter"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        website = try values.decode(String.self, forKey: .website)
        flickr = try values.decode(String.self, forKey: .flickr)
        twitter = try values.decode(String.self, forKey: .twitter)
        elonTwitter = try values.decode(String.self, forKey: .elonTwitter)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(website, forKey: .website)
        try container.encode(flickr, forKey: .flickr)
        try container.encode(twitter, forKey: .twitter)
        try container.encode(elonTwitter, forKey: .elonTwitter)
    }

}
