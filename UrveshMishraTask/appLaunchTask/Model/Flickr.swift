//
//  Flickr.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation

struct Flickr: Codable {

	let small: [String]
	let original: [String]

	private enum CodingKeys: String, CodingKey {
		case small = "small"
		case original = "original"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		small = try values.decode([String].self, forKey: .small)
		original = try values.decode([String].self, forKey: .original)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(small, forKey: .small)
		try container.encode(original, forKey: .original)
	}

}