//
//  BlockQuote.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import cmark_gfm

public class BlockQuote: BaseNode {}

// MARK: - Debug

extension BlockQuote: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Block Quote"
    }

}
