//
//  PharmacyAnnotation.swift
//
//
//  Created by Junyoung on 9/23/24.
//

import MapKit

final class PharmacyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var id: String
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, id: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.id = id
    }
}
