//
//  SessionManager.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
// The concrete implementation
//logic to build the 7-header dictionary (Authorization, Cookie, lat, long, country, language, version, device)
import Foundation
final class SessionManager: SessionManaging {
    
    private let accessToken = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJTZXNzaW9uSWQiOiIwMWEwMTQ3Ny00NWIxLTc3ZDgtYjRhOC1iODkxYTk2MzA4NDEiLCJQbGF0Zm9ybSI6IklPUyIsIlByb2ZpbGVUeXBlIjoiSEFMQU5fVVNFUl9QUk9GSUxFIiwiVmVyc2lvbiI6IjEuMCIsImlzcyI6ImhhbGFuLmlvIiwic3ViIjoiNjY5ZDExZGU4NWViMDI0NWE3ZmVkZmY4IiwiYXVkIjpbImF1dGhvcml6YXRpb24iXSwiZXhwIjoxODE4NTg1NzU2LCJpYXQiOjE3ODcwNDk3NTZ9.J9rG_4bNfG8jomM_XILxf03-Ihc8HAU9HjjLfDX68S6Zu202n0bLymHwGLtepZHf7IkfBF86TLUcIYX2-Fo1JQ"
    private let sessionCookie = "017e0ee1f26077c5f6af5fa771cd5af263d71ae377a6b23c648ec781945246bd82bec87a60780bd9905bc83870f849ea8a01c97726f4876f479214f6af21d577fb90da2049"
    private let deviceUUID = "Mobile;Iphone;iPhone_11;N/A;IOS;26.6;D10F0597-0727-4B23-8A0F-AD9525405F61;en;10800;1785149183;13.3.1;DE59F883-3100-4A6D-8CDE-9F4640C61A42"
    
    func currentHeaders() -> [String: String] {
        return [
            "Authorization": "Bearer \(accessToken)",
            "Cookie": "TS016aa6fb=\(sessionCookie)",
            "lat": "30.0595563",
            "long": "31.2996639",
            "country": "eg",
            "language": "en",
            "version": "ios-80131",
            "device": deviceUUID
        ]
    }
}

