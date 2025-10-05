//
//  SegmentationAppTests.swift
//  SegmentationAppTests
//
//  Created by Konrad Feiler on 05.10.25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Testing
@testable import SegmentationApp

struct SegmentationAppTests {

    @Test func testMLModelLoading() async throws {

        try await confirmation() { @MainActor confirmation in
            let viewModel = ViewModel()
            await viewModel.loadModel()
            confirmation()
        }
    }


}
