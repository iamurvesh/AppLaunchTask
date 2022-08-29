//
//  Reddit.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 26, 2022
//
import Foundation

struct Reddit: Codable {

	let campaign: String?
	let launch: String?
	let media: String?
	let recovery: String?

	private enum CodingKeys: String, CodingKey {
		case campaign = "campaign"
		case launch = "launch"
		case media = "media"
		case recovery = "recovery"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            campaign = try values.decode(String.self, forKey: .campaign)
        } catch  {
            campaign = ""
        }
        do {
            launch = try values.decode(String.self, forKey: .launch)
        } catch  {
            launch = ""
        }
        do {
            media = try values.decode(String.self, forKey: .media)
        } catch  {
            media = ""
        }
        do {
            recovery = try values.decode(String.self, forKey: .recovery)
        } catch  {
            recovery = ""
        }		
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(campaign, forKey: .campaign)
		try container.encode(launch, forKey: .launch)
		try container.encode(media, forKey: .media)
		try container.encode(recovery, forKey: .recovery)
	}

}
