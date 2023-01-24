//
//  ResultExtensions.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 24.01.23.
//

import Foundation

extension Result {
    var hasError: Bool {
        guard case .failure = self else { return false }
        return true
    }
}
