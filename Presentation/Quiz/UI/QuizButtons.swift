import SwiftUI

struct QuizButtons: View {
    var quizState: QuizState
    var submitAnswer: () -> Void
    var skipQuestion: () -> Void
    var moveToNextQuestion: () -> Void
    var navigateToResultScreen: () -> Void

    @State private var showSkipDialog = false
    @State private var showSubmitConfirmationDialog = false

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                // Skip Button
                Button(action: {
                    showSkipDialog = true
                }) {
                    Text("Skip")
                        .frame(maxWidth: .infinity)
                }
                .disabled(
                    quizState.isSubmitted || !quizState.selectedAnswers.isEmpty
                        || quizState.isLastItem
                )
                .buttonStyle(.borderedProminent)
                .tint(.blue)

                // Submit Button
                Button(action: {
                    showSubmitConfirmationDialog = true
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .disabled(
                    quizState.selectedAnswers.isEmpty || quizState.isSubmitted
                )
                .buttonStyle(.borderedProminent)
                .tint(.blue)

                // Next / Result Button
                Button(action: {
                    if quizState.isLastItem {
                        navigateToResultScreen()
                    } else {
                        moveToNextQuestion()
                    }
                }) {
                    Text(quizState.isLastItem ? "Result" : "Next")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!(quizState.isSubmitted || quizState.isLastItem))
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            .padding(.top, 16)
        }
        // Submit Confirmation Alert
        .alert(
            "Submit Answer?",
            isPresented: $showSubmitConfirmationDialog
        ) {
            Button("Confirm", role: .destructive) {
                submitAnswer()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to submit your answer?")
        }

        // Skip Confirmation Alert
        .alert(
            "Skip Question?",
            isPresented: $showSkipDialog
        ) {
            Button("Skip", role: .destructive) {
                skipQuestion()
            }
            .tint(.blue)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to skip this question?")
        }
    }
}

// MARK: - Preview
#Preview {
    QuizButtons(
        quizState: QuizState(
            selectedAnswers: [],
            isSubmitted: false,
            showExplanation: false,
            isLastItem: false,
            currentQuestionNumber: 20,
            totalQuestions: 30
        ),
        submitAnswer: {},
        skipQuestion: {},
        moveToNextQuestion: {},
        navigateToResultScreen: {}
    )
}
