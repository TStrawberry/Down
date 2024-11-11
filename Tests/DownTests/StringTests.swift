//
//  StringTests.swift
//  Down
//
//  Created by Rob Phillips on 6/2/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import XCTest
@testable import Down

class StringTests: XCTestCase {

    func testStringToHTML() {
        // String is assumed to contain valid Markdown
        let string = "## [Down](https://github.com/iwasrobbed/Down)"
        let down = try? string.toHTML()
        XCTAssertNotNil(down)
        XCTAssertTrue(down == "<h2><a href=\"https://github.com/iwasrobbed/Down\">Down</a></h2>\n")
    }

    func testAutolink() {
        let string = "<https://github.com/iwasrobbed/Down>"
        let down = try? string.toHTML()
        XCTAssertNotNil(down)
        XCTAssertEqual(down, "<p><a href=\"https://github.com/iwasrobbed/Down\">https://github.com/iwasrobbed/Down</a></p>\n")
    }
    
    func testAutolink2() {
        let string = "https://github.com/iwasrobbed/Down"
        let down = try? string.toHTML()
        XCTAssertNotNil(down)
        XCTAssertEqual(down, "<p><a href=\"https://github.com/iwasrobbed/Down\">https://github.com/iwasrobbed/Down</a></p>\n")
    }
    
    func testStrikethrough() {
        let string = "~~strikethrough~~ means deleted."
        let down = try? string.toHTML()
        XCTAssertNotNil(down)
        XCTAssertEqual(down, "<p><del>strikethrough</del> means deleted.</p>\n")
    }
    
    func testTable() {
        let string = """
| foo | bar |
| --- | --- |
| baz | bim |
"""
        let down = try? string.toHTML()
        XCTAssertNotNil(down)
        XCTAssertEqual(
            down,
            """
<table>
<thead>
<tr>
<th>foo</th>
<th>bar</th>
</tr>
</thead>
<tbody>
<tr>
<td>baz</td>
<td>bim</td>
</tr>
</tbody>
</table>

"""
        )
        
        func testTagfilter() {
            let string = """
<title>title should be filtered</title>
<p>title should appear</p>
"""
            let down = try? string.toHTML(.unsafe)
            XCTAssertNotNil(down)
            XCTAssertEqual(
                down,
                "<p>title should appear</p>"
            )
        }
        
        func testTasklist() {
            let string = """
- [ ] foo
- [x] bar
"""
            let down = try? string.toHTML(.unsafe)
            XCTAssertNotNil(down)
            XCTAssertEqual(
                down,
                """
<ul>
<li><input disabled="" type="checkbox"> foo</li>
<li><input checked="" disabled="" type="checkbox"> bar</li>
</ul>
"""
            )
            
            
        }
    }
}


