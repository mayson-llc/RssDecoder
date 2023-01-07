//
//  Element.swift
//  RssDecoder
//
//  Created by So Nakamura on 2023/01/07.
//  Copyright © 2023 So Nakamura. All rights reserved.
//

struct Element {
  var key: String
  var depth: Int
  var value: String = ""
  var children: [Element] = []

  mutating func set(newValue: String) {
    value = newValue
  }

  mutating func append(_ element: Element) {
    children.append(element)
  }
}
