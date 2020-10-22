//
//  BeerSearchCell.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

enum BeerSearchCell: Equatable {
    static func == (lhs: BeerSearchCell, rhs: BeerSearchCell) -> Bool {
        switch (lhs, rhs) {
        case (.beer, .beer): return true
        case (.title, .title): return true
        default: return false
        }
    }
    
    case beer(BeerTableViewCellModel)
    case title(String)
}
