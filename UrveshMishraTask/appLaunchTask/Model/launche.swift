//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation


struct launches: Codable {

	var fairings: Fairings?
	let links: LinksLaunches
	let staticFireDateUtc: String
	let staticFireDateUnix: Int
	let net: Bool
	let window: Int
	let rocket: String
	let success: Bool
	let failures: [Failures]
	let details: String
	let crew: [String]
	let ships: [String]
	let capsules: [String]
	let payloads: [String]
	let launchpad: String
	let flightNumber: Int
	let name: String
	let dateUtc: String
	let dateUnix: Int
	let dateLocal: String
	let datePrecision: String
	let upcoming: Bool
	let cores: [Cores]
	let autoUpdate: Bool
	let tbd: Bool
	let launchLibraryId: String
	let id: String

	private enum CodingKeys: String, CodingKey {
		case fairings = "fairings"
		case links = "links"
		case staticFireDateUtc = "static_fire_date_utc"
		case staticFireDateUnix = "static_fire_date_unix"
		case net = "net"
		case window = "window"
		case rocket = "rocket"
		case success = "success"
		case failures = "failures"
		case details = "details"
		case crew = "crew"
		case ships = "ships"
		case capsules = "capsules"
		case payloads = "payloads"
		case launchpad = "launchpad"
		case flightNumber = "flight_number"
		case name = "name"
		case dateUtc = "date_utc"
		case dateUnix = "date_unix"
		case dateLocal = "date_local"
		case datePrecision = "date_precision"
		case upcoming = "upcoming"
		case cores = "cores"
		case autoUpdate = "auto_update"
		case tbd = "tbd"
		case launchLibraryId = "launch_library_id"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            fairings = try values.decode(Fairings.self, forKey: .fairings)
        } catch  {
            
        }
        
		links = try values.decode(LinksLaunches.self, forKey: .links)
        do {
            staticFireDateUtc = try values.decode(String.self, forKey: .staticFireDateUtc)
        } catch  {
            staticFireDateUtc = ""
        }
        do {
            staticFireDateUnix = try values.decode(Int.self, forKey: .staticFireDateUnix)
        } catch  {
            staticFireDateUnix = 0
        }
        do {
            net = try values.decode(Bool.self, forKey: .net)
        } catch  {
            net = false
        }
        do {
            window = try values.decode(Int.self, forKey: .window)
        } catch  {
            window = 0
        }
        do {
            rocket = try values.decode(String.self, forKey: .rocket)
        } catch  {
            rocket = ""
        }
        do {
            success = try values.decode(Bool.self, forKey: .success)
        } catch  {
            success = false
        }
        do {
            failures = try values.decode([Failures].self, forKey: .failures)
        } catch  {
            failures = []
        }
		
        do {
            details = try values.decode(String.self, forKey: .details)
        } catch  {
            details = ""
        }
		
		crew = try values.decode([String].self, forKey: .crew)
		ships = try values.decode([String].self, forKey: .ships)
		capsules = try values.decode([String].self, forKey: .capsules)
		payloads = try values.decode([String].self, forKey: .payloads)
		launchpad = try values.decode(String.self, forKey: .launchpad)
		flightNumber = try values.decode(Int.self, forKey: .flightNumber)
		name = try values.decode(String.self, forKey: .name)
		dateUtc = try values.decode(String.self, forKey: .dateUtc)
		dateUnix = try values.decode(Int.self, forKey: .dateUnix)
		dateLocal = try values.decode(String.self, forKey: .dateLocal)
		datePrecision = try values.decode(String.self, forKey: .datePrecision)
		upcoming = try values.decode(Bool.self, forKey: .upcoming)
		cores = try values.decode([Cores].self, forKey: .cores)
		autoUpdate = try values.decode(Bool.self, forKey: .autoUpdate)
		tbd = try values.decode(Bool.self, forKey: .tbd)
        do {
            launchLibraryId = try values.decode(String.self, forKey: .launchLibraryId)
        }
        catch {
            launchLibraryId = ""
        }
		
		id = try values.decode(String.self, forKey: .id)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(fairings, forKey: .fairings)
		try container.encode(links, forKey: .links)
		try container.encode(staticFireDateUtc, forKey: .staticFireDateUtc)
		try container.encode(staticFireDateUnix, forKey: .staticFireDateUnix)
		try container.encode(net, forKey: .net)
		try container.encode(window, forKey: .window)
		try container.encode(rocket, forKey: .rocket)
		try container.encode(success, forKey: .success)
		try container.encode(failures, forKey: .failures)
		try container.encode(details, forKey: .details)
		try container.encode(crew, forKey: .crew)
		try container.encode(ships, forKey: .ships)
		try container.encode(capsules, forKey: .capsules)
		try container.encode(payloads, forKey: .payloads)
		try container.encode(launchpad, forKey: .launchpad)
		try container.encode(flightNumber, forKey: .flightNumber)
		try container.encode(name, forKey: .name)
		try container.encode(dateUtc, forKey: .dateUtc)
		try container.encode(dateUnix, forKey: .dateUnix)
		try container.encode(dateLocal, forKey: .dateLocal)
		try container.encode(datePrecision, forKey: .datePrecision)
		try container.encode(upcoming, forKey: .upcoming)
		try container.encode(cores, forKey: .cores)
		try container.encode(autoUpdate, forKey: .autoUpdate)
		try container.encode(tbd, forKey: .tbd)
		try container.encode(launchLibraryId, forKey: .launchLibraryId)
		try container.encode(id, forKey: .id)
	}

}

struct LinksLaunches: Codable {
    
    let patch: Patch
    let reddit: Reddit
    let flickr: Flickr
    let presskit: String
    let webcast: String
    let youtubeId: String
    let article: String
    let wikipedia: String

    private enum CodingKeys: String, CodingKey {
        case patch = "patch"
        case reddit = "reddit"
        case flickr = "flickr"
        case presskit = "presskit"
        case webcast = "webcast"
        case youtubeId = "youtube_id"
        case article = "article"
        case wikipedia = "wikipedia"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patch = try values.decode(Patch.self, forKey: .patch)
        reddit = try values.decode(Reddit.self, forKey: .reddit)
        flickr = try values.decode(Flickr.self, forKey: .flickr)
        do {
            presskit = try values.decode(String.self, forKey: .presskit)
        }
        catch{
            presskit = ""
        }
        do {
            webcast = try values.decode(String.self, forKey: .webcast)
        }
        catch{
            webcast = ""
        }
        do {
            youtubeId = try values.decode(String.self, forKey: .youtubeId)
        }
        catch{
            youtubeId = ""
        }
        do {
            article = try values.decode(String.self, forKey: .article)
        }
        catch{
            article = ""
        }
        do {
            wikipedia = try values.decode(String.self, forKey: .wikipedia)
        }
        catch{
            wikipedia = ""
        }
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patch, forKey: .patch)
        try container.encode(reddit, forKey: .reddit)
        try container.encode(flickr, forKey: .flickr)
        try container.encode(presskit, forKey: .presskit)
        try container.encode(webcast, forKey: .webcast)
        try container.encode(youtubeId, forKey: .youtubeId)
        try container.encode(article, forKey: .article)
        try container.encode(wikipedia, forKey: .wikipedia)
    }

}

