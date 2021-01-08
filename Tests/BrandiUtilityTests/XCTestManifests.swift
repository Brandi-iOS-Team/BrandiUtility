import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BrandiUtilityTests.allTests),
    ]
}
#endif
