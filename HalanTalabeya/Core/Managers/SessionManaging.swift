//
//  SessionManaging.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
// a protocol defining "what a session manager must be able to do.

import Foundation
protocol SessionManaging{
    func currentHeaders() -> [String:String]
}
