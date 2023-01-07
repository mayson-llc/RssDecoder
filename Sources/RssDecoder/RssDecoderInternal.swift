//
//  RssDecoderInternal.swift
//  RssDecoder
//
//  Created by So Nakamura on 2023/01/07.
//  Copyright © 2023 So Nakamura. All rights reserved.
//
import Foundation

struct RssDecoderInternal: Decoder {

  var element: Element
  var codingPath: [CodingKey] = []
  var userInfo: [CodingUserInfoKey : Any] = [:]

  func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
    KeyedDecodingContainer(RssKeyedDecodingContainer(referencing: self))
  }

  func unkeyedContainer() throws -> UnkeyedDecodingContainer {
    fatalError("Not implemented")
  }

  func singleValueContainer() throws -> SingleValueDecodingContainer {
    fatalError("Not implemented")
  }
}

struct RssKeyedDecodingContainer<Key> : KeyedDecodingContainerProtocol where Key: CodingKey {

  var decoder: RssDecoderInternal
  var codingPath: [CodingKey] {
    decoder.codingPath
  }
  var allKeys: [Key] {
    decoder.element.children.compactMap { Key(stringValue: $0.key) }
  }

  init(referencing decoder: RssDecoderInternal) {
    self.decoder = decoder
  }

  func contains(_ key: Key) -> Bool {
    fatalError("Not implemented")
  }

  func decodeNil(forKey key: Key) throws -> Bool {
    fatalError("Not implemented")
  }

  func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
    fatalError("Not implemented")
  }

  func decode(_ type: String.Type, forKey key: Key) throws -> String {
    decoder.element.children.first(where: { $0.key == key.stringValue })?.value ?? ""
  }

  func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
    fatalError("Not implemented")
  }

  func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
    fatalError("Not implemented")
  }

  func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
    fatalError("Not implemented")
  }

  func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
    fatalError("Not implemented")
  }

  func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
    fatalError("Not implemented")
  }

  func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
    fatalError("Not implemented")
  }

  func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
    fatalError("Not implemented")
  }

  func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
    fatalError("Not implemented")
  }

  func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
    fatalError("Not implemented")
  }

  func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
    fatalError("Not implemented")
  }

  func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
    fatalError("Not implemented")
  }

  func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
    fatalError("Not implemented")
  }

  func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
    switch type {
    case is Date.Type:
      guard let rawValue = decoder.element.children.first(where: { $0.key == key.stringValue })?.value else {
        throw DecodingError.keyNotFound(key, .init(codingPath: codingPath, debugDescription: "Not found."))
      }
      guard let date = ISO8601DateFormatter().date(from: rawValue) else {
        throw DecodingError.dataCorrupted(.init(codingPath: codingPath, debugDescription: "Date value \(rawValue) had unexpected format."))
      }
      return date as! T
    default:
      fatalError("Not implemented type: \(type)")
    }
  }

  func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
    fatalError("Not implemented")
  }

  func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
    fatalError("Not implemented")
  }

  func superDecoder() throws -> Decoder {
    fatalError("Not implemented")
  }

  func superDecoder(forKey key: Key) throws -> Decoder {
    fatalError("Not implemented")
  }
}
