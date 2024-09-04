//
//  APIEndpoint.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import Foundation

protocol APIEndpoint {
    var url: URL { get }
    var method: String { get }
    var headers: [String: String]? { get }
}
