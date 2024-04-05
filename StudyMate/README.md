# StudyMateAI

Welcome to StudyMateAI, an AI-powered study assistant and school scheduler designed to enhance the academic experience for students. StudyMateAI leverages advanced AI technology to provide personalized study recommendations, optimize your study schedule, and assist with academic resource management.

## Features

- **AI-Powered Study Assistant**: Engage with our AI to get study tips, reminders, and motivational support tailored to your academic needs.
- **Smart Scheduler**: Plan your study routine and manage deadlines using an AI algorithm that considers your class times, due dates, and personal preferences.
- **Calendar Integration**: View and edit your class schedules, exams, study sessions, and assignments in an intuitive calendar.
- **Assignment Tracking**: Keep track of your tasks and monitor your progress, with automated reminders to keep you on track.
- **Educational Resource Hub**: Access a centralized library of your study materials and receive AI-recommended resources to bolster your learning.
- **Wellness and Motivation**: Manage your well-being with scheduled reminders for breaks and track your study milestones with rewarding achievements.
- **Collaborative Tools**: Connect and study with peers using shared calendars and notes, enhanced with real-time communication tools.

## Getting Started

To run StudyMateAI on your device, you'll need to have Flutter installed and set up. Clone the repository to your local machine and ensure you are on the latest stable version of Flutter.

1. Clone the repository:
   ```
   git clone https://github.com/jrutyna2/StudyMateAI.git
   ```
2. Navigate to the cloned repo:
   ```
   cd StudyMateAI
   ```
3. Run the app on your connected device or emulator:
   ```
   flutter run
   ```

## Backend Integration

StudyMateAI uses Firebase for its backend services including real-time database, authentication, and cloud functions. To connect to the backend, ensure you have set up your Firebase project and have the `google-services.json` for Android or `GoogleService-Info.plist` for iOS placed in the respective directories.

## OpenAI API

Our AI functionalities are powered by OpenAI's GPT-3. To utilize these features, you must obtain an API key from OpenAI and set it in the environment variables or configuration file as per Flutter best practices.

## State Management

This application uses the Provider package for state management. State is handled in a clean and efficient manner, allowing for reactive updates within the UI.

## Third-Party Packages

StudyMateAI uses various third-party packages to enhance its UI and functionalities. These packages include but are not limited to:
- `table_calendar`: For displaying a dynamic and interactive calendar.
- `flutter_dialogflow`: For integrating dialogflow and OpenAI GPT-3 functionalities.
- `flutter_slidable`: For creating dismissible list items in the study resources section.

## Assets

All image assets are stored within the `assets` directory. Ensure that all assets are declared in the `pubspec.yaml` file for them to be available within the Flutter app.

## Testing

StudyMateAI comes with a suite of tests to ensure the quality and performance of the application. Run the tests using the following command:
   ```
   flutter test
   ```

## Contribution

Contributions to StudyMateAI are welcome. If you have suggestions or issues, please open an issue in the repository, or even better, submit a pull request with your proposed changes.

## License

StudyMateAI is open-source software licensed under the [LICENSE NAME].

## Contact

For any additional information or inquiries, please reach out to jrutyna@uoguelph.ca.

Thank you for using StudyMateAI, and happy studying!
