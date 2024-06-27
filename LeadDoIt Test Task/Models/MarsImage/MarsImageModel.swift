//
//  MarsImageModel.swift
//  LeadDoIt Test Task
//
//  Created by MacBook on 27.06.2024.
//

import SwiftUI

enum RoverType {
    var asString: String {
        return ""
    }
}

enum CameraType {
    var asString: String {
        return ""
    }
}

struct MarsImageModel {
    let rover: RoverType
    let camera: CameraType
    let date: Date
    let image: Image
}
