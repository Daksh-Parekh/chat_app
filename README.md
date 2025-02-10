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
<img src="https://github.com/user-attachments/assets/64ce78e2-5d2e-43e1-97c9-2e1cc99ffe9f" width="300px">|
<img src="https://github.com/user-attachments/assets/5b4beb83-33b5-4443-bc4a-45cc73c058f9" width="300px">|
<img src="https://github.com/user-attachments/assets/e170269f-21aa-4c76-aa93-c26a21210eef" width="300px">|

<img src="https://github.com/user-attachments/assets/fc0cac5e-282e-45d3-ac7d-b27986e8af7f" width="300px">|
<img src="https://github.com/user-attachments/assets/4ec8e33c-fc79-4ad4-97c4-aace9a63005b" width="300px">|
<img src="https://github.com/user-attachments/assets/1581a55e-abda-4c55-bf6d-1d73809c797b" width="300px">|

<img src="https://github.com/user-attachments/assets/cccb480d-20b8-4fa7-a880-cd0c5860a695" width="300px">|
<img src="https://github.com/user-attachments/assets/3b6eebd7-657b-4546-80a4-1901915c98d5" width="300px">|
<img src="https://github.com/user-attachments/assets/e2ff299d-b5cf-40cc-a5a7-a67bf6328767" width="300px">|

## Video Demo


https://github.com/user-attachments/assets/928effc6-4d82-4f13-ab46-3dd56aab2563

