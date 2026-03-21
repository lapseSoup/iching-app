import Foundation

enum IChingError: LocalizedError {
    case saveFailed(underlying: Error)
    case deleteFailed(underlying: Error)
    case hexagramResolutionFailed(lineValues: [Int])
    case invalidLineCount(expected: Int, actual: Int)

    var errorDescription: String? {
        switch self {
        case .saveFailed:
            return "Unable to save your data. Please try again."
        case .deleteFailed:
            return "Unable to delete. Please try again."
        case .hexagramResolutionFailed:
            return "Could not determine the hexagram for this reading. Please try again."
        case .invalidLineCount(let expected, let actual):
            return "Expected \(expected) lines but got \(actual). Please try again."
        }
    }
}
