//
//  LGFSafe.swift
//  LGFSwiftTool
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019 来国锋. All rights reserved.
//

import Foundation

// MARK: - json 解析：安全过滤无法转换的类型
/// let json = """
/// [
///     {"name": "Taro", "age": 20},
///     {"name": "Hanako", "age": "にゃーん"}
/// ]
/// """.data(using: .utf8)!
///
/// struct User: Decodable {
///     let name: String
///     let age: Int
/// }
///
/// let users = try! JSONDecoder().decode([Safe<User>].self,
///                                       from: json)
///
/// users[0].value?.name -> "Taro"
/// users[0].value?.age -> 20
/// age "にゃーん" 无法转换因此直接放弃转换
/// users[1].value -> nil
public struct Safe<Wrapped: Decodable>: Codable {
    public let value: Wrapped?
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Wrapped.self)
        } catch {
            self.value = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
