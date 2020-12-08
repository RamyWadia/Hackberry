//
//  HeaderModel.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-08.
//

import Foundation

struct HeaderModel {
    var headerImageName: String
    var label1Text: String
    var label2Text: String
    var label3Text: String?
    
    init(imageName: String, text1: String, text2: String, text3: String) {
        headerImageName = imageName
        label1Text = text1
        label2Text = text2
        label3Text = text3
    }
}
