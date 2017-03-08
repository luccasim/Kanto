//
//  Place.swift
//  Kanto
//
//  Created by luc Casimir on 07/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation
import MapKit

enum Type : Int {
    case ville
    case monument
}

class Place : NSObject {
    let name: String
    let details: String
    let longitude : CLLocationDegrees
    let latitude : CLLocationDegrees
    let type : Type
    
    init(Title t:String, SubTitle st:String, Lalitude latitude:CLLocationDegrees, Longitude longitude:CLLocationDegrees, Type type:Type) {
        self.name = t
        self.details = st
        self.latitude = latitude
        self.longitude = longitude
        self.type = type
    }
}

extension Place : MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title : String?{
        return name
    }
    
    var subtitle: String?{
        return details
    }
    
    var location : CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
