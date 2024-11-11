//
//  DownASTRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation
import cmark_gfm
import cmark_gfm_extensions

public protocol DownASTRenderable: DownRenderable {

    func toAST(_ options: DownOptions) throws -> CMarkNode

}

extension DownASTRenderable {

    /// Generates an abstract syntax tree from the `markdownString` property.
    ///
    /// - Parametera:
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     An abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    /// `MarkdownToASTError` if conversion fails.

    public func toAST(_ options: DownOptions = .default) throws -> CMarkNode {
        return try DownASTRenderer.stringToAST(markdownString, options: options)
    }

    /// Parses the `markdownString` property into an abstract syntax tree and returns the root `Document` node.
    ///
    /// - Parameters:
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     The root Document node for the abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    ///     `MarkdownToASTError` if conversion fails.

    public func toDocument(_ options: DownOptions = .default) throws -> Document {
        let tree = try toAST(options)

        guard tree.type == CMARK_NODE_DOCUMENT else {
            throw DownErrors.astRenderingError
        }

        return Document(cmarkNode: tree)
    }

}

public struct DownASTRenderer {

    /// Generates an abstract syntax tree from the given CommonMark Markdown string.
    ///
    /// **Important:** It is the caller's responsibility to call `cmark_node_free(ast)` on the returned value.
    ///
    /// - Parameters:
    ///     - string: A string containing CommonMark Markdown.
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     An abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    ///     `MarkdownToASTError` if conversion fails.
    public static func stringToAST(_ string: String, options: DownOptions = .default) throws -> CMarkNode {
        return try cmark_parse_document_with_ext(string, options.rawValue)
    }

    static func cmark_parse_document_with_ext(_ markdown: String, _ options: Int32) throws -> UnsafeMutablePointer<cmark_node> {
        cmark_gfm_core_extensions_ensure_registered()
        
        let parser = cmark_parser_new(options)
        defer { cmark_parser_free(parser) }
        let extensionNames: Set<String> = ["autolink", "strikethrough", "tagfilter", "tasklist", "table"]
        for extensionName in extensionNames {
          guard let syntaxExtension = cmark_find_syntax_extension(extensionName) else {
            continue
          }
          cmark_parser_attach_syntax_extension(parser, syntaxExtension)
        }

        // Parse the Markdown document
        cmark_parser_feed(parser, markdown, markdown.utf8.count)
        guard let document = cmark_parser_finish(parser) else {
            throw DownErrors.markdownToASTError
        }
        return document
    }
}
