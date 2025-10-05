//
//  SegmentationAppTests.swift
//  SegmentationAppTests
//
//  Created by Konrad Feiler on 05.10.25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Combine
import UIKit
import Testing
@testable import SegmentationApp

class TestBundleInternalClass {}

@MainActor
@Suite(.serialized) struct SegmentationAppTests {

    @Test func testMLModelLoading() async throws {
        let viewModel = ViewModel()

        await confirmation() { confirmation in
            await viewModel.loadModel()
            confirmation()
        }

        #expect(viewModel.isModelLoaded == true)
    }

    @Test func testImageClassification() async throws {
        let uiImage = UIImage(named: "test_img", in: Bundle(for: TestBundleInternalClass.self), with: nil)
        try #require(uiImage != nil, "Test image not found")

        let viewModel = ViewModel()

        await confirmation() { confirmation in
            await viewModel.loadModel()
            confirmation()
        }

        try #require(viewModel.isModelLoaded == true)

        viewModel.handleSelectedImage(uiImage!)

        await confirmation() { confirmation in
            let labelsExpectation = viewModel.$predictedLabels
                .filter { !$0.isEmpty } // Wait until labels are actually populated

            let first = await labelsExpectation.values.first(where: { _ in true})!
            #expect(first.count > 0)

            confirmation()
        }

        #expect(viewModel.predictedLabels.count > 0)
    }

}
