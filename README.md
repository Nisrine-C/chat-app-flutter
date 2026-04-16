# Chat App Flutter

A modern chat application built with Flutter, utilizing a clean architecture and robust state management. This project demonstrates the implementation of a real-time messaging interface with a focus on scalability and performance.

## Features

- **Conversation Management**: Browse through a list of active conversations with a dedicated list screen.
- **Detailed Chat View**: Seamless messaging interface for individual or group discussions.
- **State Management**: Powered by **BLoC (Business Logic Component)** for predictable state transitions and clean separation of concerns.
- **Cross-Platform**: Designed to run on Android, iOS, Web, macOS, Linux, and Windows.

## Technical Stack

- **Framework**: [Flutter](https://flutter.dev) (SDK ^3.7.2)
- **State Management**: `flutter_bloc`
- **Model Comparison**: `equatable` for efficient object comparisons.
- **Design System**: Material Design with support for Cupertino icons.

## Project Structure

The project follows a repository-pattern-based architecture:

```text
lib/
├── blocs/           # Business logic components for state management
├── models/          # Data models for Users, Messages, and Conversations
├── repositories/    # Data layer handling API calls or local storage
├── screens/         # UI Screen implementations
│   ├── conversation_list_screen.dart  # Main chat list view
│   └── detail_screen.dart             # Individual chat/message view
└── main.dart        # Application entry point
```

## ⚙️ Getting Started

### Prerequisites

- Flutter SDK (version 3.7.2 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Nisrine-C/ChatApp_Flutter.git
   cd ChatApp_Flutter
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 🧪 Testing

The project includes a `test/` directory for unit and widget testing. To run tests:

```bash
flutter test
```

## 📄 License

This project is open-source. Refer to the repository for licensing details.
