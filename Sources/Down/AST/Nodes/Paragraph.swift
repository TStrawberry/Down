//
//  Paragraph.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import cmark_gfm

public class Paragraph: BaseNode {}

// MARK: - Debug

extension Paragraph: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Paragraph"
    }

}
