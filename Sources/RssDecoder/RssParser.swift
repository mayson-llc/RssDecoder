//
//  RssParser.swift
//  RssDecoder
//
//  Created by So Nakamura on 2023/01/07.
//  Copyright © 2023 So Nakamura. All rights reserved.
//

import Foundation

class RssParser: NSObject {

  private var stack = [Element]()
  private var currentDepth = 0
  private var currentText = ""
  var parseResult: Element? {
    stack.first
  }

  override init() {
    super.init()
  }

  func parse(data: Data) {
    let parser = XMLParser(data: data)
    parser.shouldProcessNamespaces = false
    parser.delegate = self
    parser.parse()
  }
}

extension RssParser: XMLParserDelegate {

  func parser(
    _ parser: XMLParser,
    didStartElement elementName: String,
    namespaceURI: String?,
    qualifiedName qName: String?,
    attributes attributeDict: [String : String] = [:]
  ) {
    currentDepth += 1
    currentText = ""
    let formattedName = elementName.components(separatedBy: ":").last!
    stack.append(Element(key: formattedName, depth: currentDepth))
  }

  func parser(
    _ parser: XMLParser,
    foundCharacters string: String
  ) {
    let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !value.isEmpty else { return }
    currentText += value
  }

  func parser(
    _ parser: XMLParser,
    didEndElement elementName: String,
    namespaceURI: String?,
    qualifiedName qName: String?
  ) {
    defer { currentDepth -= 1 }
    if currentText.isEmpty, stack.last!.children.isEmpty {
      stack.removeLast()
      return
    }
    guard
      let index = stack.lastIndex(where: { $0.depth == currentDepth - 1 }),
      var latest = stack.popLast()
    else { return }
    var target = stack.remove(at: index)
    latest.set(newValue: currentText)
    target.append(latest)
    stack.insert(target, at: index)
  }

  func parserDidEndDocument(_ parser: XMLParser) {
    if stack.count != 1 {
      assertionFailure("Parsed unsupported RSS format.")
    }
  }
}
