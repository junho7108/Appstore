//
//  ActionAttachable.swift
//  Appstore
//
//  Created by Junho Yoon on 9/22/24.
//

import Foundation

protocol ActionAttachable {
    associatedtype ActionType
    
    var completableAction: ((ActionType) -> Void)? { get set }
}
