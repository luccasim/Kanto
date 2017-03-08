//
//  PlacesManager.swift
//  Kanto
//
//  Created by luc Casimir on 07/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation
import MapKit

class PlacesManager {
    private var data = [Place]()
    
    public var first : Place{
        return data.first!
    }
    
    public var count : Int {
        return data.count
    }
    
    public var getData : [Place]{
        return data
    }
    
    init() {
        let ecole = Place(Title: "42", SubTitle: "ecole du numérique", Lalitude: 48.89650732, Longitude: 2.31852293, Type: .monument)
        let tokyo = Place(Title: "Tokyo", SubTitle: "Capitale du Japon", Lalitude: 35.652832, Longitude: 139.839478, Type: .ville)
        let lyon = Place(Title: "Lyon", SubTitle: "rien", Lalitude: 45.7484600, Longitude: 4.8467100, Type: .ville)
        let eiffel = Place(Title: "Tour Eiffel", SubTitle: "Monuments de paris", Lalitude: 48.858093, Longitude: 2.294694, Type: .monument)
        data.append(ecole)
        data.append(tokyo)
        data.append(lyon)
        data.append(eiffel)
        data.append(Place(Title: "Paris", SubTitle: "Capitale de france", Lalitude: 48.866667, Longitude: 2.333333, Type: .ville))
        data.append(Place(Title: "Sainte-Genevieve-des-Bois", SubTitle: "Home", Lalitude: 48.640842, Longitude: 2.325921, Type: .ville))
        data.append(Place(Title: "Berlin", SubTitle: "Germany Capitale", Lalitude: 52.520007, Longitude: 13.404954, Type: .ville))
        data.append(Place(Title: "Louvre", SubTitle: "Palais du Louvre", Lalitude: 48.860611, Longitude: 2.337644, Type: .monument))
    }
    
    subscript (index:Int) -> Place{
        get {
            return data[index]
        }
        set{
            data.insert(newValue, at: index)
        }
    }
}
