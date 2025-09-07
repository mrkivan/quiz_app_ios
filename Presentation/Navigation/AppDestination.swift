// MARK: - Navigation Destinations
enum AppDestination: Hashable {
    case quizSet(quizSetData: QuizSetScreenData)
    case quizScreen(quizData: QuizScreenData)
    case resultScreen(key: String)
}
