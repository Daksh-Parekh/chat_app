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
<img src="https://github.com/user-attachments/assets/f2edeca1-0667-4770-bb62-381083b77d1e" width="300px">|
<img src="https://github.com/user-attachments/assets/0cca0a82-9f95-415f-b397-627110799dc2" width="300px">|

<img src="https://github.com/user-attachments/assets/f5c4ca4d-cca9-4e7f-bbc7-2d01debe1c69" width="300px">|
<img src="https://github.com/user-attachments/assets/8ddd7e57-861a-481c-b060-eeee71cdab40" width="300px">|
<img src="https://github.com/user-attachments/assets/d897f6b6-44c3-4762-a528-b6d95d11d84c" width="300px">|

<img src="https://github.com/user-attachments/assets/5c85325b-adcf-48b7-b2ff-4c68be431320" width="300px">|
<img src="https://github.com/user-attachments/assets/49de9366-ac2e-4aec-8638-dad07880e3d3" width="300px">|
<img src="https://github.com/user-attachments/assets/e2ff299d-b5cf-40cc-a5a7-a67bf6328767" width="300px">|

## Video Demo



https://github.com/user-attachments/assets/4926c3c2-00e2-4cac-a978-84f459a73414

