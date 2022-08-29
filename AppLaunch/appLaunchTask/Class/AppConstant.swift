//
//  AppConstant.swift
//  UrveshMishraTask
//
//  Created by Urvesh Mishra on 26/08/22.
//

import Foundation

let BASE_URL         = "https://api.spacexdata.com/v4/"

struct API {
    public let kcompany     =   "company"
}


enum LaunchStatus {
    case success
    case failed
    case both
}

enum SortedByName {
    case ascending
    case descending
    case both
}
