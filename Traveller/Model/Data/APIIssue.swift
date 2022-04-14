//
//  APIIssue.swift
//  Traveller
//
//  Created by Clément FLORET on 07/04/2022.
//

import Foundation

enum APIIssue: Error {
    case decoding(desc: String)
    case parsing(desc: String)
}
