//
//  MKCoordinateRegion.swift
//  oHash
//
//  Created by Brendan White on 3/4/2024.
//

import Foundation
import MapKit

extension MKCoordinateRegion : RawRepresentable {

    var minDelta: Double {
        Double.minimum(
            self.span.latitudeDelta,
            self.span.longitudeDelta
        )
    }

    var bottomLeft:CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(
            self.center.latitude - (self.span.latitudeDelta / 2.0),
            self.center.longitude - (self.span.longitudeDelta / 2.0)
        )
    }
    
    var topRight:CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(
            self.center.latitude + (self.span.latitudeDelta / 2.0),
            self.center.longitude + (self.span.longitudeDelta / 2.0)
        )
    }
    
    // Thanks to jnpdx for the code below, to make the region RawRepresentable
    // https://stackoverflow.com/a/67215739/2434429

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
