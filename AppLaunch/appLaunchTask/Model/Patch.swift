//
//  Patch.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation

struct Patch: Codable {

	let small: String
	let large: String

	private enum CodingKeys: String, CodingKey {
		case small = "small"
		case large = "large"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            small = try values.decode(String.self, forKey: .small)
        } catch  {
            small = ""
        }
        do {
            large = try values.decode(String.self, forKey: .large)
        } catch  {
            large = ""
        }
	
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(small, forKey: .small)
		try container.encode(large, forKey: .large)
	}

}
