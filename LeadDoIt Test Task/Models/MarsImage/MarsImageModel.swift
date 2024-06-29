//
//  MarsImageModel.swift
//  LeadDoIt Test Task
//
//  Created by MacBook on 27.06.2024.
//

import SwiftUI

protocol Filterable: Hashable {
    var asString: String { get }
    var abbreviated: String { get }
}

struct MarsImageModel {
    let rover: RoverType
    let camera: CameraType
    let date: Date
    let image: Image
}
