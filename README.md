# RssDecoder

Yet another the minimum swift package for RSS decoder.

## Installation

Add a dependencty to your `package.swift` like below.
```swift
// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "RssViewer",
  dependencies: [
    .package(url: "https://github.com/mayson-llc/RssDecoder.git", .branch("main")) // NEW!
  ],
  targets: [
    .target(name: "RssViewerTest", dependencies: ["RssDecoder"])
  ]
)
```
Then
```sh
$ swift build
```

## Usage

See also [tests](Tests/RssDecoderTests)

## Motivation

We, MAYSON LLC, had been using [MWFeedParser](https://github.com/mwaterfall/MWFeedParser) for a long time in our projects but wanted to have a new one that has minimal capability for parsing RSS feeds and supports SPM natively.

_No matter to say, MWFeedParser was a very nice library and we'd really appreciated 🥰_

## License

[MIT](LICENSE.md)
