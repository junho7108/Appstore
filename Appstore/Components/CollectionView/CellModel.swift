//
//  CellModel.swift
//  Appstore
//
//  Created by Junho Yoon on 9/21/24.
//

import Foundation

struct CellModel: ModelAdaptable, Hashable {
    
    static func == (lhs: CellModel, rhs: CellModel) -> Bool {
        if let lhsModel = lhs.model as? AnyHashable, let rhsModel = rhs.model as? AnyHashable {
            return lhsModel == rhsModel
        } else {
            return lhs.id == rhs.id
        }
    }
    
    func hash(into hasher: inout Hasher) {
        if let model = model as? AnyHashable {
            hasher.combine(model)
        } else {
            hasher.combine(id)
        }
    }
    
    
    var id: UUID = UUID()
    var identifier: String
    var model: any Decodable
    
    init(identifier: String, model: any Decodable) {
        self.identifier = identifier
        self.model = model
    }
    
    init<T>(identifier: T.Type, model: any Decodable) {
        self.identifier = String(describing: identifier)
        self.model = model
    }
}
