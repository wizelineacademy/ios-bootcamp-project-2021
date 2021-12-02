//
//  CastDummy.swift
//  TheMovieDbTests
//
//  Created by Javier Cueto on 01/12/21.
//

@testable import TheMovieDb

struct CastDummy {
    
    var cast: [Cast] = []
    
    init() {
        let cast1 = Cast(name: nil, character: nil, profilePath: nil)
        cast.append(cast1)
        
        let cast2 = Cast(name: "Ben Affleck", character: "Batman", profilePath: "Ben_Affleck_by_Gage_Skidmore_3.jpg")
        cast.append(cast2)
        
        let cast3 = Cast(name: "Keanu Reeves", character: nil, profilePath: nil)
        cast.append(cast3)
    }
    
    func getSingleCast() -> Cast {
        let indexRandom = Int.random(in: 0..<cast.count)
        return cast[indexRandom]
    }
    
    func getSpecificCast(index: Int) -> Cast {
        return cast[index]
    }
    
}
