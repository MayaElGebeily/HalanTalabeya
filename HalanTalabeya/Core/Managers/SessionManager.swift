//
//  SessionManager.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
// The concrete implementation
//logic to build the 7-header dictionary (Authorization, Cookie, lat, long, country, language, version, device)

import Foundation
import CoreLocation
import UIKit

final class SessionManager: SessionManaging {
    
    private let tokenKey = "accessToken"
    private let cookieKey = "sessionCookie"
    
    init(){
        seedDevCredentialsIfNeeded()
    }
    func currentHeaders() -> [String: String] {
        let device = KeychainService.shared.read(key: "deviceUUID") ?? deviceIdentifier()
        print("📱 Device header: \(device)") // TEMP
        let token = KeychainService.shared.read(key: tokenKey)
        print("🔑 Token: \(token?.prefix(20) ?? "NIL")...") // TEMP

        var headers: [String: String] = [
            "lat": "\(currentLatitude())",
            "long": "\(currentLongitude())",
            "country": "eg",
            "language": Locale.current.language.languageCode?.identifier ?? "en",
            "version": appVersionHeader(),
            "device": device // FIXED — was deviceIdentifier()
        ]
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        if let cookie = KeychainService.shared.read(key: cookieKey) {
            headers["Cookie"] = "TS016aa6fb=\(cookie)"
        }
        return headers
    }
    func saveSesssion(accessToken: String , sessionCookie: String) {
        KeychainService.shared.save(key: tokenKey , value: accessToken)
        KeychainService.shared.save(key: cookieKey , value: sessionCookie)
    }
    func clearSession(){
        KeychainService.shared.delete(key: tokenKey)
        KeychainService.shared.delete(key: cookieKey)
    }
    private func currentLatitude() -> Double {
        30.0595563
    }

    private func currentLongitude() -> Double {
        31.2996639
    }

    private func appVersionHeader() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        return "ios-\(version)"
    }

    private func deviceIdentifier() -> String {
        UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
    }
    
    //bridge development config → Keychain
    private func seedDevCredentialsIfNeeded() {
        #if DEBUG
        KeychainService.shared.delete(key: tokenKey)
        KeychainService.shared.delete(key: cookieKey)
        KeychainService.shared.delete(key: "deviceUUID")
        
        guard KeychainService.shared.read(key: tokenKey) == nil else { return }

        let devToken = Bundle.main.object(forInfoDictionaryKey: "DEV_ACCESS_TOKEN") as? String
        let devCookie = Bundle.main.object(forInfoDictionaryKey: "DEV_SESSION_COOKIE") as? String
        let devDevice = "Mobile;Iphone;iPhone_11;N/A;IOS;26.6;D10F0597-0727-4B23-8A0F-AD9525405F61;en;10800;1785149183;13.3.1;DE59F883-3100-4A6D-8CDE-9F4640C61A42" // hardcoded, no escaping issues

        if let devToken = devToken, let devCookie = devCookie, !devToken.isEmpty {
            saveSesssion(accessToken: devToken, sessionCookie: devCookie)
            KeychainService.shared.save(key: "deviceUUID", value: devDevice)
        }
        #endif
    }
}
