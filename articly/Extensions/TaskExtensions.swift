//
//  TaskExtensions.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 20.01.23.
//

import Foundation

/// 'AsyncTask' looks better than 'Task' in code
typealias AsyncTask = _Concurrency.Task

extension AsyncTask where Failure == Error {
    /// Retry 'operation' 'count' times where each retry is delayed by 'retryDelay'. After 'count' times will throw
    /// - Parameters:
    ///   - count: how many times to retry
    ///   - retryDelay: how long to delay between retries (seconds)
    ///   - operation: async code to retry
    /// - Returns: result of 'operation'
    @discardableResult
    static func retrying(
        count: Int = 3,
        retryDelay: TimeInterval = 2,
        operation: @Sendable @escaping () async throws -> Success
    ) async throws -> Success {
        for _ in 0 ..< count - 1 {
            do {
                return try await operation()
            } catch {
                let oneSecond = TimeInterval(1_000_000_000)
                let delay = UInt64(oneSecond * retryDelay)
                try await AsyncTask.sleep(nanoseconds: delay)

                continue
            }
        }

        return try await operation()
    }
}
