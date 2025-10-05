//
//  SegmentationAppTests.swift
//  SegmentationAppTests
//
//  Created by Konrad Feiler on 05.10.25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Testing
@testable import SegmentationApp

@MainActor
struct SegmentationAppTests {

    @Test func testMLModelLoading() async throws {
        let viewModel = ViewModel()

        await confirmation() { confirmation in
            await viewModel.loadModel()
            confirmation()
        }

        #expect(viewModel.isModelLoaded == true)
    }


}
