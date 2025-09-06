import Combine

struct GetQuizSetListUseCase {
    private let repository: QuizRepository

    init(repository: QuizRepository) {
        self.repository = repository
    }

    func execute(topic: String) -> AnyPublisher<QuizSetData?, Never> {
        return repository.getQuizListByTopic(topic: topic)
    }
}
