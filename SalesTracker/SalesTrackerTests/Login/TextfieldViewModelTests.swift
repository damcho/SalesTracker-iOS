//
//  Test.swift
//  SalesTrackerTests
//
//  Created by Damian Modernell on 16/2/25.
//

import Testing

final class TextfieldViewModel {
    var textfieldLabel: String = "" {
        didSet {
            didChangeTextfieldLabel(textfieldLabel)
        }
    }
    let didChangeTextfieldLabel: (String) -> Void
    
    init(didChangeCallback: @escaping (String) -> Void) {
        self.didChangeTextfieldLabel = didChangeCallback
    }
}

struct TextfieldViewModelTests {
    @Test func does_not_notify_username_change_on_init() throws {
        var usernameChangedCallCount = 0
        _ = makeSUT { _ in
            usernameChangedCallCount += 1
        }

        #expect(usernameChangedCallCount == 0)
    }
    
    @Test func notifies_username_text_changed() throws {
        var username = ""
        let sut = makeSUT { newUsername in
            username = newUsername
        }
        
        sut.textfieldLabel = "t"

        #expect(username == "t")
        
        sut.textfieldLabel = "te"

        #expect(username == "te")
    }
}

extension TextfieldViewModelTests {
    func makeSUT(callback: @escaping (String) -> Void) -> TextfieldViewModel {
        return TextfieldViewModel(didChangeCallback: callback)
    }
}
