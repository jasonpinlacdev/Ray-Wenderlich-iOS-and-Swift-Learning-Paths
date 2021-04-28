//
//  Data.swift
//  UITableView DataSource SectionHeaderFooterSupplmentaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit


class Data {
    enum ColorsSection: String, CaseIterable {
        case warm = "WARM COLORS"
        case cold = "COLD COLORS"
    }
    
    static let shared = Data()
    
    private init() { }
    
    let colors: [ColorsSection: [Color] ] = [
        .warm : [ Color(name: "Red", bgColor: .systemRed),
                  Color(name: "Orange", bgColor: .systemOrange),
                  Color(name: "Yellow", bgColor: .systemYellow),
                  Color(name: "Red", bgColor: .systemRed),
                  Color(name: "Orange", bgColor: .systemOrange),
                  Color(name: "Yellow", bgColor: .systemYellow),
                  Color(name: "Red", bgColor: .systemRed),
                  Color(name: "Orange", bgColor: .systemOrange),
                  Color(name: "Yellow", bgColor: .systemYellow),],
        
        .cold : [ Color(name: "Blue", bgColor: .systemBlue),
                  Color(name: "Indigo", bgColor: .systemIndigo),
                  Color(name: "Violet", bgColor: .systemPurple),
                  Color(name: "Blue", bgColor: .systemBlue),
                  Color(name: "Indigo", bgColor: .systemIndigo),
                  Color(name: "Violet", bgColor: .systemPurple),
                  Color(name: "Blue", bgColor: .systemBlue),
                  Color(name: "Indigo", bgColor: .systemIndigo),
                  Color(name: "Violet", bgColor: .systemPurple),]
    ]
}
