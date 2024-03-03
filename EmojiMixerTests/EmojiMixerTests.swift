//
//  EmojiMixerTests.swift
//  EmojiMixerTests
//
//  Created by admin on 03.03.2024.
//

import XCTest
import SnapshotTesting
@testable import EmojiMixer

final class EmojiMixerTests: XCTestCase {

    func testViewController() throws {
        let vc = EmojiMixerViewController()
        let viewModel = EmojiMixesViewModel()
        
        viewModel.deleteAll()
        viewModel.addFixedEmojiMix()
        
        assertSnapshot(matching: vc, as: .image, record: false)
    }

}
