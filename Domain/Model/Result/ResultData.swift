import Foundation

struct ResultData: Codable {
    let quizTitle: String?
    let quizDescription: String?
    let resultItems: [Item]
    let totalCorrectAnswers: Int
    let totalQuestions: Int
    let resultPercentage: Int

    struct Item: Codable {
        let questionId: Int
        let question: String
        let result: Bool
        let answerSectionTitle: String?
        let correctAnswer: [String]
        let explanation: String
        let isSkipped: Bool
    }
}
