
---

# Admin Panel for Pure Drop Waters

This is the **Admin Panel** for managing bills, notifications, and other administrative functions of the Pure Drop Waters Billing Application. The panel allows administrators to efficiently manage user data, monitor billing information, and send notifications.

---

## Table of Contents
1. [Features](#features)
2. [Technologies Used](#technologies-used)
3. [Project Structure](#project-structure)
4. [Setup and Installation](#setup-and-installation)
5. [Backend API Integration](#backend-api-integration)
6. [Building the APK](#building-the-apk)
7. [Future Improvements](#future-improvements)

---

## Features
- **User Management**: View and manage user billing details and account statuses.
- **Bill Management**: Generate, view, and update bills for users.
- **Notification Management**: Send notifications to users regarding pending payments or other important updates.
- **Responsive Design**: Optimized for multiple device sizes.
- **Secure Login**: Only authorized administrators can access the dashboard.

---

## Technologies Used
- **Frontend**: Flutter (Dart)
- **Backend API**: PHP and MySQL
- **Database**: MySQL
- **State Management**: Provider (or equivalent Flutter state management solution)
- **IDE**: VS Code

---

## Project Structure
```
admin_panel/
├── android/              # Android-specific build files
├── ios/                  # iOS-specific build files
├── lib/                  # Flutter source code
│   ├── main.dart         # Entry point of the app
│   ├── screens/          # Screens for different functionalities
│   │   ├── login_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── bills_screen.dart
│   │   ├── notifications_screen.dart
│   ├── widgets/          # Custom widgets
│   │   ├── custom_card.dart
│   │   ├── custom_button.dart
│   ├── services/         # API integration and backend logic
│   │   ├── api_service.dart
├── pubspec.yaml          # Project dependencies
└── README.md             # Project documentation
```

---

## Setup and Installation

### Prerequisites
1. Ensure you have Flutter installed. If not, follow the [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
2. Install a code editor (preferably **VS Code**) and the required plugins for Flutter.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/NexusGKSoftwares/admin_panel.git
   cd admin_panel
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Connect a physical device or start an emulator.
4. Run the app:
   ```bash
   flutter run
   ```

---

## Backend API Integration
The admin panel communicates with the backend via API endpoints. The following are some key endpoints:

- **Fetch Bills**:  
  **Method**: `GET`  
  **Endpoint**: `/api/bills`  
  **Description**: Retrieves all bills from the database.

- **Send Notifications**:  
  **Method**: `POST`  
  **Endpoint**: `/api/notifications/send`  
  **Description**: Sends notifications to users about pending payments.

- **Login Admin**:  
  **Method**: `POST`  
  **Endpoint**: `/api/admin/login`  
  **Description**: Authenticates the admin user.

Ensure the backend is running and accessible for proper API functionality.

---

## Building the APK
To release the APK:
1. Clean previous builds:
   ```bash
   flutter clean
   ```
2. Build the APK:
   ```bash
   flutter build apk --release
   ```
3. Find the APK in the following directory:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

---

## Future Improvements
- Add a **Statistics Dashboard** for visualizing billing trends.
- Implement **Role-Based Access Control (RBAC)** for different admin levels.
- Include detailed logs for admin actions.

---

Feel free to contribute to this project by submitting pull requests or reporting issues.

**Maintainer**: [Gideon Bett](https://github.com/NexusGKSoftwares)  
For inquiries or support, contact **nexusgksoftwares@gmail.com**.  

---