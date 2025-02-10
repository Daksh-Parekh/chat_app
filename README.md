# Flutter Chat App

A real-time chat application built using Flutter and Firebase. This app allows users to log in using Google, anonymously, or with an email and password. Users can see all other users on the homepage, log out, and chat with each other. Additional features include message editing (within 10 minutes), message deletion, and message timestamps.

## Features

- **User Authentication**
  - Google Sign-In
  - Anonymous Login
  - Email & Password Login
- **Real-time Chat**
  - Users can see all registered users
  - Private one-on-one chats
  - Messages display the time they were sent
- **Message Management**
  - Edit messages within 10 minutes of sending
  - Delete messages permanently
- **Logout Functionality**
  - Users can log out at any time

## Technologies Used

- **Flutter** - UI Framework
- **Firebase Authentication** - User authentication
- **Firebase Firestore** - Real-time database for storing messages
- **Firebase Cloud Functions** (if used) - To handle background processes
- **GetX** or **Provider** (if used) - State management

## Installation

1. Clone the repository:
   ```yaml
   git clone https://github.com/your-username/flutter-chat-app.git
   cd flutter-chat-app
2. Install dependencies:
   ```yaml
   flutter pub get
3. Set up Firebase:
  - Create a Firebase project at Firebase Console.
  - Enable Authentication (Google, Anonymous, Email/Password).
  - Set up Firestore Database.
  - Download and configure google-services.json (Android) and GoogleService-Info.plist (iOS).
    
4. Run the app:
   ```yaml
   flutter run

## Usage

1. Register or log in using Google, anonymously, or with email and password.
2. View the list of available users.
3. Tap on a user to start a conversation.
4. Send messages, edit them within 10 minutes, or delete them.
5. Messages display the time they were sent.
6. Log out when finished.

# Screenshots & Video
  ## Screenshots

  ## Video Demo
