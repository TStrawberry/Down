//
//  SoftBreak.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import cmark_gfm

public class SoftBreak: BaseNode {}

// MARK: - Debug

extension SoftBreak: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Soft Break"
    }

}
