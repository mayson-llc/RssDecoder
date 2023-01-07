//
//  RssDecoder.swift
//  RssDecoder
//
//  Created by So Nakamura on 2023/01/07.
//  Copyright © 2023 So Nakamura. All rights reserved.
//

import Foundation

public struct RssDecoder {

  public var rootElementNameForFeed: String

  public init(rootElementNameForFeed: String = "item") {
    self.rootElementNameForFeed = rootElementNameForFeed
  }

  public func decodeToArray<T>(of type: T.Type, from: Data) throws -> [T] where T : Decodable {
    let parser = RssParser()
    parser.parse(data: from)
    var cursor: [Element?] = []
    cursor.append(parser.parseResult)
    var feedElements: [Element] = []
    while let element = cursor.popLast() {
      if element?.key == rootElementNameForFeed, element != nil {
        feedElements.append(element!)
      } else {
        cursor.append(contentsOf: element?.children ?? [])
      }
    }
    guard !feedElements.isEmpty else {
      throw DecodingError.valueNotFound(
        T.self,
        .init(codingPath: [], debugDescription: "\(rootElementNameForFeed) was not found in the parsed content")
      )
    }
    return try feedElements.map {
      try T(from: RssDecoderInternal(element: $0))
    }
  }
}

//#if canImport(Combine)
//import protocol Combine.TopLevelDecoder
//
//extension RssDecoder: TopLevelDecoder {
//  public typealias Input = Data
//}
//#endif
