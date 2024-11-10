//
//  ThematicBreak.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import cmark_gfm

public class ThematicBreak: BaseNode {}

// MARK: - Debug

extension ThematicBreak: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Thematic Break"
    }

}
