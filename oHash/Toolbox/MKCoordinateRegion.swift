//
//  MKCoordinateRegion.swift
//  oHash
//
//  Created by Brendan White on 3/4/2024.
//

import Foundation
import MapKit

// Thanks to jnpdx for this code
// https://stackoverflow.com/a/67215739/2434429

extension MKCoordinateRegion : RawRepresentable {
    struct RepresentableForm : Codable {
        var centerLat : Double
        var centerLong : Double
        var latDelta: Double
        var longDelta : Double
    }
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8), let result = try? JSONDecoder().decode(RepresentableForm.self, from: data)
        else {
            return nil
        }
        self = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: result.centerLat, longitude: result.centerLong),
            span: MKCoordinateSpan(latitudeDelta: result.latDelta, longitudeDelta: result.longDelta)
        )
    }
    
    public var rawValue: String {
        do {
            let data = try JSONEncoder().encode(RepresentableForm(centerLat: self.center.latitude, centerLong: self.center.longitude, latDelta: self.span.latitudeDelta, longDelta: self.span.longitudeDelta))
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            fatalError()
        }
    }
}