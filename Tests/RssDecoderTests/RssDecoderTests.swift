//
//  RssDecoderTests.swift
//  RssDecoder
//
//  Created by So Nakamura on 2023/01/07.
//  Copyright © 2023 So Nakamura. All rights reserved.
//

import Combine
import XCTest

@testable import RssDecoder

struct Feed: Decodable {
  var title: String
  var link: String
  var date: Date
}

final class RssDecoderTests: XCTestCase {

  private var cancellables = [AnyCancellable]()

  func testRssDecode() throws {
    let expectation = expectation(description: "Decoded rss feeds")
    Just("FakeContent.rdf")
      .tryMap { try fixtureData(for: $0) }
      .tryMap { try RssDecoder().decodeToArray(of: Feed.self, from: $0) }
      .eraseToAnyPublisher()
      .sink { _ in
        // no-op
      } receiveValue: { data in
        XCTAssertEqual(data.isEmpty, false)
        expectation.fulfill()
      }
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }
}

func fixtureData(for fixture: String, path: String = #file) throws -> Data {
  let url = URL(fileURLWithPath: path)
  let testsDir = url.deletingLastPathComponent()
  let fixturesDir = testsDir.appendingPathComponent("Fixtures")
  let resourceUrl = fixturesDir.appendingPathComponent(fixture)
  return try Data(contentsOf: resourceUrl)
}
