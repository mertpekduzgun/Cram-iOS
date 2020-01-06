//
//  Encodable.swift
//  Pointcy
//
//  Created by Yusuf on 1.10.2019.
//  Copyright © 2019 Ovidos Creative. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
