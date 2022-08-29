//
//  Cores.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation

struct Cores: Codable {

	let core: String
	let flight: Int
	let gridfins: Bool
	let legs: Bool
	let reused: Bool
	let landingAttempt: Bool
	let landingSuccess: Bool
	let landingType: String
	let landpad: String

	private enum CodingKeys: String, CodingKey {
		case core = "core"
		case flight = "flight"
		case gridfins = "gridfins"
		case legs = "legs"
		case reused = "reused"
		case landingAttempt = "landing_attempt"
		case landingSuccess = "landing_success"
		case landingType = "landing_type"
		case landpad = "landpad"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            core = try values.decode(String.self, forKey: .core)
        } catch  {
            core = ""
        }
        do {
            flight = try values.decode(Int.self, forKey: .flight)
        } catch  {
            flight = 0
        }
        do {
            gridfins = try values.decode(Bool.self, forKey: .gridfins)
        } catch  {
            gridfins = false
        }
        do {
            legs = try values.decode(Bool.self, forKey: .legs)
        } catch  {
            legs = false
        }
        do {
            reused = try values.decode(Bool.self, forKey: .reused)
        } catch  {
            reused = false
        }
        do {
            landingAttempt = try values.decode(Bool.self, forKey: .landingAttempt)
        } catch  {
            landingAttempt = false
        }
		
        do {
            landingSuccess = try values.decode(Bool.self, forKey: .landingSuccess)
        } catch  {
            landingSuccess = false
        }
        do {
            landingType = try values.decode(String.self, forKey: .landingType)
        } catch  {
            landingType = ""
        }
        do {
            landpad = try values.decode(String.self, forKey: .landpad)
        } catch  {
            landpad = ""
        }
		
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(core, forKey: .core)
		try container.encode(flight, forKey: .flight)
		try container.encode(gridfins, forKey: .gridfins)
		try container.encode(legs, forKey: .legs)
		try container.encode(reused, forKey: .reused)
		try container.encode(landingAttempt, forKey: .landingAttempt)
		try container.encode(landingSuccess, forKey: .landingSuccess)
		try container.encode(landingType, forKey: .landingType)
		try container.encode(landpad, forKey: .landpad)
	}

}
