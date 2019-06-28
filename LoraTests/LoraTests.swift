//
//  LoraTests.swift
//  LoraTests
//
//  Created by maylee on 2019/06/28.
//  Copyright © 2019 rollmind. All rights reserved.
//

import XCTest
@testable import Lora

class LoraTests: XCTestCase {

    let lo = Localization.en
    let decoder = LocalizableStringDecoder()
    
    func testItemFromKeyValueText() {
        var value = #""hello" = "Hello\#nWorld";"#
        var decoded = try! decoder.decode(fromKeyTextString: value)
        XCTAssertEqual(decoded, LocalizableStringItem(locale: lo, key: "hello", text: "Hello\nWorld"))
    }

}

enum Localization: String, Codable, Hashable {
    case en = "English"
    case ko = "Korean"
}

struct LocalizableStringItem: Codable, Hashable {
    let locale: Localization
    let key: String
    let text: String
}

final class LocalizableStringDecoder {
    
    enum Error: Swift.Error {
        case unableDecodeKeyTextItem
    }
    
    func decode(fromKeyTextString pair: String) throws -> LocalizableStringItem {
        let array: [String] = pair.components(separatedBy: "=").map({ $0.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .init(charactersIn: "\";")) })
        guard array.count == 2 else { throw Error.unableDecodeKeyTextItem }
        return .init(locale: .en, key: array[0], text: array[1])
    }
    
}
