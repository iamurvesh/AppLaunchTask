//
//  Fairings.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation

struct Fairings: Codable {

	let reused: Bool
	let recoveryAttempt: Bool
	let recovered: Bool
	let ships: [String]

	private enum CodingKeys: String, CodingKey {
		case reused = "reused"
		case recoveryAttempt = "recovery_attempt"
		case recovered = "recovered"
		case ships = "ships"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            reused = try values.decode(Bool.self, forKey: .reused)
        }
        catch {
            reused = false
        }
        do {
            recoveryAttempt = try values.decode(Bool.self, forKey: .recoveryAttempt)
        }
        catch {
            recoveryAttempt = false
        }
        do {
            recovered = try values.decode(Bool.self, forKey: .recovered)
        }
        catch {
            recovered = false
        }
        do {
            ships = try values.decode([String].self, forKey: .ships)
        }
        catch {
            ships = []
        }
        

	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(reused, forKey: .reused)
		try container.encode(recoveryAttempt, forKey: .recoveryAttempt)
		try container.encode(recovered, forKey: .recovered)
		try container.encode(ships, forKey: .ships)
	}

}
