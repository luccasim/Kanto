//
//  Place.swift
//  Kanto
//
//  Created by luc Casimir on 07/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation
import MapKit

class Place : NSObject {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(Title t:String, SubTitle st:String, coordinate: CLLocationCoordinate2D) {
        self.title = t
        self.subtitle = st
        self.coordinate = coordinate
    }
}

extension Place : MKAnnotation {
    
}
