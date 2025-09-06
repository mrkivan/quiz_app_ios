import Foundation

struct QuizSetData: Codable {
    let total: Int
    let title: String
    let topic: String
    let description: String
    let sectionId: Int
    let sections: [SectionItem]

    struct SectionItem: Codable {
        let title: String
        let description: String
        let position: Int
        let fileName: String
        var previousResult: ResultData? = nil
    }
}
