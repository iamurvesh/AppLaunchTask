//
//  Failures.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation

struct Failures: Codable {

	let time: Int
	let altitude: String
	let reason: String

	private enum CodingKeys: String, CodingKey {
		case time = "time"
		case altitude = "altitude"
		case reason = "reason"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		time = try values.decode(Int.self, forKey: .time)
        do {
            altitude = try values.decode(String.self, forKey: .altitude)
        }
        catch{
            altitude = ""
        }
        do {
            reason = try values.decode(String.self, forKey: .reason)
        }
        catch{
            reason = ""
        }
		
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(time, forKey: .time)
		try container.encode(altitude, forKey: .altitude)
		try container.encode(reason, forKey: .reason)
	}

}
